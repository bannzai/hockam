class GoodsController < ApplicationController
  def minne
    @goods = MinneGood.order('item_id DESC').page(params[:page]).per(15)
    render template: 'goods/goods'
  end

  def suzuri
    @goods = SuzuriGood.order('item_id DESC').page(params[:page]).per(15)
    render template: 'goods/goods'
  end

  def stores
    render :stores
  end
end
