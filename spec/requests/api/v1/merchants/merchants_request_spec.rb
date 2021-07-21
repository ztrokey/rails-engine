require 'rails_helper'

RSpec.describe 'Merchant requests' do
  it 'returns a list of 20 merchants per page' do
    create_list(:merchant, 25)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchant_data = JSON.parse(response.body, symbolize_names: true)
    merchants = merchant_data[:data]

    expect(merchants.count).to eq(20)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)
      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to be_a(String)
      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_a(Hash)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'sends puts the remainder on the last page' do
    create_list(:merchant, 25)

    get '/api/v1/merchants?page=2'

    expect(response).to be_successful

    merchant_data = JSON.parse(response.body, symbolize_names: true)
    merchants = merchant_data[:data]

    expect(merchants.count).to eq(5)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)
      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to be_a(String)
      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_a(Hash)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'can return a merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant_data = JSON.parse(response.body, symbolize_names: true)
    merchant = merchant_data[:data]

    expect(response).to be_successful
    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_a(String)
    expect(merchant).to have_key(:type)
    expect(merchant[:type]).to be_a(String)
    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to be_a(Hash)
    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
  end
end
