class AiurController < ApplicationController
  class Converter < Kramdown::Converter::Html
    def convert_codeblock(block, _indent)
      @codeblock_count ||= 0
      result = "<component-preview>" +
        "<iframe src='/aiur/atoms/strong/#{@codeblock_count}' class='rendered'></iframe>" +
        "<pre class='highlight'>#{Rouge.highlight(block.value, block.options[:lang], 'html')}</pre>" +
        "</component-preview>"
      @codeblock_count += 1
      result
    end
  end

  MATCH = /\A(?<component>.*)\/(?<example>\d+)\z/

  def show
    if MATCH.match(params[:component])
      render_example(Regexp.last_match[:component], Regexp.last_match[:example].to_i)
    else
      render_documentation(params[:component])
    end
  end

  private

  def render_documentation(component)
    result = parse_document(component, Converter)
    render inline: result.join, layout: "aiur"
  rescue Errno::ENOENT
    render inline: "No Documentation Found for #{component}", layout: "aiur", status: 404
  end

  def render_example(component, example)
    result = parse_document(component, Kramdown::Converter::HashAST)
    code, language = find_codeblock(result, example)
    render inline: code, type: language
  end

  def parse_document(component, converter)
    path = Rails.root.join("app", "components", component, "doc.html.md")
    raw = File.read(path)
    root, _warnings = Kramdown::Parser::Kramdown.parse(raw)
    converter.convert(root)
  end

  def find_codeblock(document, example)
    codeblock = document[0][:children].find_all { |child| child[:type] == :codeblock }[example]
    [ codeblock[:value], codeblock[:options][:lang].to_sym ]
  end
end
