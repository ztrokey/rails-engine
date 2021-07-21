class Api::V1::Merchants::SearchController < ApplicationController
  def index
    merchant = Merchant.where('name ILIKE ?', "%#{params[:name]}%")
                       .order(:name)
                       .first
    render json: MerchantSerializer.new(merchant).serializable_hash.to_json
  end
end
