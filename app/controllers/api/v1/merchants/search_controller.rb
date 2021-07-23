# frozen_string_literal: true

module Api
  module V1
    module Merchants
      class SearchController < ApplicationController
        def index
          merchant = Merchant.where('name ILIKE ?', "%#{params[:name]}%")
                             .order(:name)
                             .first
          render json: MerchantSerializer.new(merchant).serializable_hash.to_json
        end
      end
    end
  end
end
