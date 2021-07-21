require 'rails_helper'

RSpec.describe 'Merchant search requests' do
  it 'returns one merchant based on name search critera' do
    merchant1 = Merchant.create!(name: 'Turing')
    merchant2 = Merchant.create!(name: 'Ring World')

    get '/api/v1/merchants/find?name=ring'

    expect(response).to be_successful

    merchant_data = JSON.parse(response.body, symbolize_names: true)
    merchant = merchant_data[:data]

    expect(merchant[:attributes][:name]).to eq(merchant2.name)
    expect(merchant[:attributes][:name]).to_not eq(merchant1.name)
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
