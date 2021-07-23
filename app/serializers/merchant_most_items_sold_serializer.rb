# frozen_string_literal: true

class MerchantMostItemsSoldSerializer
  include JSONAPI::Serializer

  set_type :items_sold

  attributes :name
  attributes :count, &:sold_items
end
