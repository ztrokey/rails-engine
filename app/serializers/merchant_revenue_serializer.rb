class MerchantRevenueSerializer
  include JSONAPI::Serializer

  set_type :merchant_revenue

  attributes :revenue do |merchant|
    merchant.total_revenue
  end
end
