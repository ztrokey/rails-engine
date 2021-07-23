# frozen_string_literal: true

class MerchantRevenueSerializer
  include JSONAPI::Serializer

  set_type :merchant_revenue

  attributes :revenue, &:total_revenue
end
