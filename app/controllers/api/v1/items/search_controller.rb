# frozen_string_literal: true

module Api
  module V1
    module Items
      class SearchController < ApplicationController
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
          end
        end
      end
    end
  end
end
