# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Item search requests' do
  before :each do
    @merchant = create(:merchant)

    @item1 = Item.create!(
      name: 'Titanium Ring',
      description: 'name test, max test',
      unit_price: 5.5,
      merchant_id: @merchant.id
    )
    @item2 = Item.create!(
      name: 'Turing',
      description: 'name, min test, max test, min & max',
      unit_price: 9.8,
      merchant_id: @merchant.id
    )
    @item3 = Item.create!(
      name: 'Pizza',
      description: 'min test',
      unit_price: 20.5,
      merchant_id: @merchant.id
    )
  end
  it 'returns all items based on name search critera' do
    get '/api/v1/items/find_all?name=ring'

    items_data = JSON.parse(response.body, symbolize_names: true)
    items = items_data[:data]

    expect(response).to be_successful

    expect(items.first[:attributes][:name]).to eq(@item1.name)
    expect(items.last[:attributes][:name]).to eq(@item2.name)
    expect(items.first[:attributes][:description]).to eq(@item1.description)
    expect(items.last[:attributes][:description]).to eq(@item2.description)
    expect(items.first[:attributes][:unit_price]).to eq(@item1.unit_price)
    expect(items.last[:attributes][:unit_price]).to eq(@item2.unit_price)
    expect(items.first[:attributes][:merchant_id]).to eq(@item1.merchant_id)
    expect(items.last[:attributes][:merchant_id]).to eq(@item2.merchant_id)
  end
  it 'returns all items based on min price' do
    get '/api/v1/items/find_all?min_price=7'

    items_data = JSON.parse(response.body, symbolize_names: true)
    items = items_data[:data]

    expect(response).to be_successful

    expect(items.first[:attributes][:name]).to eq(@item2.name)
    expect(items.last[:attributes][:name]).to eq(@item3.name)
    expect(items.first[:attributes][:description]).to eq(@item2.description)
    expect(items.last[:attributes][:description]).to eq(@item3.description)
    expect(items.first[:attributes][:unit_price]).to eq(@item2.unit_price)
    expect(items.last[:attributes][:unit_price]).to eq(@item3.unit_price)
    expect(items.first[:attributes][:merchant_id]).to eq(@item2.merchant_id)
    expect(items.last[:attributes][:merchant_id]).to eq(@item3.merchant_id)
  end
  it 'returns all items based on max price' do
    get '/api/v1/items/find_all?max_price=10'

    items_data = JSON.parse(response.body, symbolize_names: true)
    items = items_data[:data]

    expect(response).to be_successful

    expect(items.first[:attributes][:name]).to eq(@item1.name)
    expect(items.last[:attributes][:name]).to eq(@item2.name)
    expect(items.first[:attributes][:description]).to eq(@item1.description)
    expect(items.last[:attributes][:description]).to eq(@item2.description)
    expect(items.first[:attributes][:unit_price]).to eq(@item1.unit_price)
    expect(items.last[:attributes][:unit_price]).to eq(@item2.unit_price)
    expect(items.first[:attributes][:merchant_id]).to eq(@item1.merchant_id)
    expect(items.last[:attributes][:merchant_id]).to eq(@item2.merchant_id)
  end
  it 'returns all items between min and max price' do
    get '/api/v1/items/find_all?max_price=10&min_price=8'

    items_data = JSON.parse(response.body, symbolize_names: true)
    items = items_data[:data]

    expect(response).to be_successful

    expect(items.last[:attributes][:name]).to eq(@item2.name)
    expect(items.last[:attributes][:description]).to eq(@item2.description)
    expect(items.last[:attributes][:unit_price]).to eq(@item2.unit_price)
    expect(items.last[:attributes][:merchant_id]).to eq(@item2.merchant_id)
  end
end
