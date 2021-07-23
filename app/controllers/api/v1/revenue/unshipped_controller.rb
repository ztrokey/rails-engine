class Api::V1::Revenue::UnshippedController < ApplicationController
  def index
    quantity = params.fetch(:quantity, 10).to_i
    invoices = Invoice.unshipped_invoices_potential_revenue(quantity)
    render json: UnshippedSerializer.new(invoices).serializable_hash.to_json
  end
end
