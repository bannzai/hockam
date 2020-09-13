class GoodsController < ApplicationController
  def minne
    @goods = MinneGood.where(:is_hidden => false).order('item_id DESC').page(params[:page]).per(15)
    render template: 'goods/goods'
  end

  def suzuri
    @goods = SuzuriGood.where(:is_hidden => false).order('item_id DESC').page(params[:page]).per(15)
    render template: 'goods/goods'
  end

  def stores
    render :stores
  end
end
