class Api::V1::ItemsController < ApplicationController
  def index
    items = Merchant.find(params[:merchant_id]).items
    render json: ItemSerializer.new(items).serializable_hash.to_json
  end

  def show
    item = item.find(params[:id])
    render json: item
  end
end
