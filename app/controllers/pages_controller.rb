class PagesController < ApplicationController
  def home
    minne_goods = MinneGood.where(:is_hidden => false).order('item_id DESC').take(20)
    suzuri_goods = SuzuriGood.where(:is_hidden => false).order('item_id DESC').take(20)
    @goods = combine(minne_goods, suzuri_goods)
    @news_list = News.where(:is_hidden => false).order('priority DESC').take(8)
    render :home
  end

  def combine(minne, suzuri)
    minne.zip(suzuri).flatten
  end
end
