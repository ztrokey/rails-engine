class MerchantSerializer
  include JSONAPI::Serializer

  set_type :merchant
  attributes :name
  # has_many :items
end
