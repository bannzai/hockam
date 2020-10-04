class NewsController < ApplicationController
  def index
    @news_list = News.where(:is_hidden => false).order('priority DESC').page(params[:page]).per(15)
  end

  def show
    @news = News.find_by(id: params[:id], is_hidden: false)
  end
end
