class MerchantMostRevenueSerializer
  include JSONAPI::Serializer

  set_type :merchant_name_revenue

  attributes :name
  attributes :revenue do |merchant|
    merchant.total_revenue
  end
end
