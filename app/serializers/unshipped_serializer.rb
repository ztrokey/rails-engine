# frozen_string_literal: true

class UnshippedSerializer
  include JSONAPI::Serializer

  set_type :unshipped_order

  attributes :potential_revenue, &:potential_revenue
end
