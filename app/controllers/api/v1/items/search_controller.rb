class Api::V1::Items::SearchController < ApplicationController
  def index
    if params[:name]
      items = Item.where('name ILIKE ?', "%#{params[:name]}%")
      render json: ItemSerializer.new(items).serializable_hash.to_json
    elsif params[:min_price] && params[:max_price]
      items = Item.where unit_price: params[:min_price]..params[:max_price]
      render json: ItemSerializer.new(items).serializable_hash.to_json
    elsif params[:min_price]
      items = Item.where('unit_price > ?', params[:min_price].to_s)
      render json: ItemSerializer.new(items).serializable_hash.to_json
    elsif params[:max_price]
      items = Item.where('unit_price < ?', params[:max_price].to_s)
      render json: ItemSerializer.new(items).serializable_hash.to_json
    elsif params[:name] && params[:min_price] || params[:max_price]
      # error message here
    end
  end
end
