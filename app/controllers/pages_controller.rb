class PagesController < ApplicationController
  def home
    @minne_goods = MinneGood.where(:is_hidden => false).order('item_id DESC').take(20)
    @suzuri_goods = SuzuriGood.where(:is_hidden => false).order('item_id DESC').take(20)
    @news_list = News.where(:is_hidden => false).order('priority DESC').take(20)
    render :home
  end
end
