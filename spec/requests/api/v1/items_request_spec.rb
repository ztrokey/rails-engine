require 'rails_helper'

RSpec.describe 'Item requests' do
  it 'returns a list items for a merchant' do
    merchant = create(:merchant)
    item1 = Item.create!(
      name: 'one',
      description: 'one again',
      unit_price: 1.1,
      merchant_id: merchant.id
    )
    item2 = Item.create!(
      name: 'two',
      description: 'two again',
      unit_price: 2.2,
      merchant_id: merchant.id
    )
    item3 = Item.create!(
      name: 'three',
      description: 'three again',
      unit_price: 3.3,
      merchant_id: merchant.id
    )

    merchant.items << item1
    merchant.items << item2
    merchant.items << item3

    get "/api/v1/merchants/#{merchant.id}/items"

    item_data = JSON.parse(response.body, symbolize_names: true)
    items = item_data[:data]

    expect(item_data).to have_key(:data)
    expect(item_data[:data]).to be_an(Array)
    expect(items.count).to eq(3)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)
      expect(item).to have_key(:type)
      expect(item[:type]).to be_a(String)
      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end
  end
end
