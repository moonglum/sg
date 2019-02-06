class ApplicationController < ActionController::Base
  append_view_path Rails.root.join("app", "components")

  def template(name, locals: {}, layout: "application")
    render "templates/#{name}/#{name}", locals: locals, layout: layout
  end
end
