class GoodsController < ApplicationController
  def minne
    @minne_goods = MinneGood.page(params[:page]).per(15)
  end

  def suzuri
    @suzuri_goods = SuzuriGood.page(params[:page]).per(15)
  end

  def stores
    render :stores
  end
end
