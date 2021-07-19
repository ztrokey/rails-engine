class Api::V1::ItemsController < ApplicationController
  def index
    if params[:merchant_id]
      items = Merchant.find(params[:merchant_id]).items
      render json: ItemSerializer.new(items).serializable_hash.to_json
    elsif
      page = [params.fetch(:page, 1).to_i, 1].max
      per_page = params.fetch(:per_page, 20).to_i
      items = Item.limit(per_page).offset((page - 1) * per_page)
      render json: ItemSerializer.new(items).serializable_hash.to_json
      # require 'pry'; binding.pry
    end
  end

  # def show
  #   item = item.find(params[:id])
  #   render json: item
  # end
end
