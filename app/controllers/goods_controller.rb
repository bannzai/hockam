class GoodsController < ApplicationController
  def minne
    @minne_goods = MinneGood.all[0...50]
  end

  def suzuri
    render :suzuri
  end

  def stores
    render :stores
  end
end
