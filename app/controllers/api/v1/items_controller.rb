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
    end
  end

  def show
    if params[:item_id]
      merchant = Item.find(params[:item_id]).merchant
      render json: MerchantSerializer.new(merchant).serializable_hash.to_json
    elsif
      item = Item.find(params[:id])
      render json: ItemSerializer.new(item).serializable_hash.to_json
    end
  end

  def create
    item = Item.create!(item_params)
    render json: ItemSerializer.new(item).serializable_hash.to_json, status: :created
  end

  def update
    updated_item = Item.update(params[:id], item_params)
    render json: ItemSerializer.new(updated_item).serializable_hash.to_json
  end

  def destroy
    Item.destroy(params[:id])
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
