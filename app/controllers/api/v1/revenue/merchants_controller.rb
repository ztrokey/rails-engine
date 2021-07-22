class Api::V1::Revenue::MerchantsController < ApplicationController
   def show
    merchant = Merchant.find(params[:id])
    render json: MerchantRevenueSerializer.new(merchant).serializable_hash.to_json
    # require 'pry'; binding.pry
   end
end
