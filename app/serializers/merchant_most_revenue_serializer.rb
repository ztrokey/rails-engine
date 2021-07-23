# frozen_string_literal: true

class MerchantMostRevenueSerializer
  include JSONAPI::Serializer

  set_type :merchant_name_revenue

  attributes :name
  attributes :revenue, &:total_revenue
end
