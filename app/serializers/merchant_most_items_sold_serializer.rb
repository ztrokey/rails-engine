class MerchantMostItemsSoldSerializer
  include JSONAPI::Serializer

  set_type :items_sold

  attributes :name
  attributes :count do |merchant|
    merchant.sold_items
  end
end
