class DemoController < ApplicationController
  def index
    template "demo_index", locals: { a: 12 }
  end
end
