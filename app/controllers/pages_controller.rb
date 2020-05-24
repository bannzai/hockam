class PagesController < ApplicationController
  def home
    render html: 'Hello, page'
  end
  def about
  end
end
