# frozen_string_literal: true

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

  it 'returns all items 20 at a time' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    merchant1_items = create_list(:item, 25, merchant_id: merchant1.id)
    merchant2_items = create_list(:item, 35, merchant_id: merchant2.id)

    get '/api/v1/items'

    expect(response).to be_successful

    item_data = JSON.parse(response.body, symbolize_names: true)
    items = item_data[:data]

    expect(item_data).to be_a(Hash)
    expect(item_data).to have_key(:data)
    expect(item_data[:data]).to be_an(Array)
    expect(items.count).to eq(20)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)
      expect(item).to have_key(:type)
      expect(item[:type]).to be_a(String)
      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end
  it 'returns one item' do
    merchant = create(:merchant)
    item1 = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item1.id}"

    item_data = JSON.parse(response.body, symbolize_names: true)
    item = item_data[:data]

    expect(response).to be_successful

    expect(item_data).to be_a(Hash)
    expect(item_data).to have_key(:data)
    expect(item_data[:data]).to be_an(Hash)

    expect(item).to have_key(:id)
    expect(item[:id]).to be_a(String)
    expect(item).to have_key(:type)
    expect(item[:type]).to be_a(String)
    expect(item).to have_key(:attributes)
    expect(item[:attributes]).to be_a(Hash)
    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to be_a(String)
    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_a(String)
    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_a(Float)
    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to be_a(Integer)
  end
  it 'can create an item' do
    merchant = create(:merchant)

    post '/api/v1/items', params: {
      name: 'one',
      description: 'one again',
      unit_price: 1.1,
      merchant_id: merchant.id
    }

    item_data = JSON.parse(response.body, symbolize_names: true)
    item = item_data[:data]

    expect(response).to be_successful

    expect(item_data).to be_a(Hash)
    expect(item_data).to have_key(:data)
    expect(item_data[:data]).to be_an(Hash)

    expect(item).to have_key(:id)
    expect(item[:id]).to be_a(String)
    expect(item).to have_key(:type)
    expect(item[:type]).to be_a(String)
    expect(item).to have_key(:attributes)
    expect(item[:attributes]).to be_a(Hash)
    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to be_a(String)
    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_a(String)
    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_a(Float)
    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to be_a(Integer)
  end
  it 'can update an item' do
    merchant = create(:merchant)
    item = Item.create!(
      name: 'one',
      description: 'one again',
      unit_price: 1.1,
      merchant_id: merchant.id
    )

    put "/api/v1/items/#{item.id}", params: {
      name: 'not one anymore'
    }

    item_data = JSON.parse(response.body, symbolize_names: true)
    item = item_data[:data]

    expect(response).to be_successful
    expect(item[:attributes][:name]).to eq('not one anymore')
  end
  it 'can delete and item' do
    merchant = create(:merchant)
    merchant_items = create_list(:item, 25, merchant_id: merchant.id)
    delete_me = merchant_items.last

    expect(Item.all.count).to eq(25)

    delete "/api/v1/items/#{delete_me.id}"

    expect(response.status).to eq(204)
    expect(Item.all.count).to eq(24)
  end
  it 'can get an items merchant' do
    merchant = create(:merchant)
    item1 = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item1.id}/merchant"

    merchant_data = JSON.parse(response.body, symbolize_names: true)
    returned_merchant = merchant_data[:data]

    expect(response).to be_successful
    expect(merchant_data).to be_a(Hash)
    expect(merchant_data).to have_key(:data)
    expect(returned_merchant).to be_a(Hash)
    expect(returned_merchant).to have_key(:id)
    expect(returned_merchant[:id]).to be_a(String)
    expect(returned_merchant).to have_key(:type)
    expect(returned_merchant[:type]).to be_a(String)
    expect(returned_merchant).to have_key(:attributes)
    expect(returned_merchant[:attributes]).to be_a(Hash)
    expect(returned_merchant[:attributes]).to have_key(:name)
    expect(returned_merchant[:attributes][:name]).to be_a(String)
  end
end
