class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    quantity = params.fetch(:quantity, 5).to_i
    merchants = Merchant.most_items_sold(quantity)
    render json: MerchantMostItemsSoldSerializer.new(merchants).serializable_hash.to_json
  end
end
