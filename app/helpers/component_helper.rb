module ComponentHelper
  def atom(name, locals = {}, &block)
    component "atoms/#{name}/#{name}", locals, &block
  end

  def molecule(name, locals = {}, &block)
    component "molecules/#{name}/#{name}", locals, &block
  end

  def organism(name, locals = {}, &block)
    component "organisms/#{name}/#{name}", locals, &block
  end

  private

  def component(name, locals = {}, &block)
    if block_given?
      # using `layout` is a trick to allow passing blocks to partials
      # (cf. http://stackoverflow.com/a/2952056)
      render layout: name, locals: locals, &block
    else
      render partial: name, locals: locals
    end
  end
end
