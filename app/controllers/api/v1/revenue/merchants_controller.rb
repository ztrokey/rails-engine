# frozen_string_literal: true

module Api
  module V1
    module Revenue
      class MerchantsController < ApplicationController
        def index
          merchants = Merchant.most_revenue(params[:quantity])
          render json: MerchantMostRevenueSerializer.new(merchants).serializable_hash.to_json
        end

        def show
          merchant = Merchant.find(params[:id])
          render json: MerchantRevenueSerializer.new(merchant).serializable_hash.to_json
        end
      end
    end
  end
end
