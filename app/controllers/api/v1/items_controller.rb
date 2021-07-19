class Api::V1::ItemsController < ApplicationController
  def index
    merchant_items = Merchant.find(params[:merchant_id]).items
    render json: merchant_items
  end

  def show
    item = item.find(params[:id])
    render json: item
  end
end
