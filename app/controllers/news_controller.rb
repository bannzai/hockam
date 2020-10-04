class NewsController < ApplicationController
  def index
    @news_list = News.all
  end

  def show
  end
end
