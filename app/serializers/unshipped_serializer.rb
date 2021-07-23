class UnshippedSerializer
  include JSONAPI::Serializer

  set_type :unshipped_order

  attributes :potential_revenue do |invoice|
    invoice.potential_revenue
  end
end
