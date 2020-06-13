class GoodsController < ApplicationController
  def minne
    @minne_goods = MinneGood.page(params[:page]).per(15)
  end

  def suzuri
    render :suzuri
  end

  def stores
    render :stores
  end
end
