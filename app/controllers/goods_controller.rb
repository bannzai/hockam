class GoodsController < ApplicationController
  def minne
    @minne_goods = MinneGood.order('item_id DESC').page(params[:page]).per(15)
  end

  def suzuri
    @suzuri_goods = SuzuriGood.order('item_id DESC').page(params[:page]).per(15)
  end

  def stores
    render :stores
  end
end
