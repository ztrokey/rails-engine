require 'rails_helper'

RSpec.describe 'total revenue' do
  it 'returns total revenue for a given merchant' do
    merchant = create(:merchant)
    item1 = Item.create!(
      name: 'one',
      description: 'one again',
      unit_price: 10.0,
      merchant_id: merchant.id
    )
    item2 = Item.create!(
      name: 'two',
      description: 'two again',
      unit_price: 20.0,
      merchant_id: merchant.id
    )
    item3 = Item.create!(
      name: 'three',
      description: 'three again',
      unit_price: 30.0,
      merchant_id: merchant.id
    )

    merchant.items << item1
    merchant.items << item2
    merchant.items << item3

    customer = Customer.create!(first_name: 'first',
                                last_name: 'last')

    invoice1 = Invoice.create!(customer_id: customer.id,
                               merchant_id: merchant.id,
                               status: 'shipped')

    invoice2 = Invoice.create!(customer_id: customer.id,
                               merchant_id: merchant.id,
                               status: 'shipped')

    invoice3 = Invoice.create!(customer_id: customer.id,
                               merchant_id: merchant.id,
                               status: 'shipped')

    ii11 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 10)
    ii12 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 5, unit_price: 20)
    ii13 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice1.id, quantity: 5, unit_price: 30)

    ii21 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice2.id, quantity: 10, unit_price: 10)
    ii22 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice2.id, quantity: 10, unit_price: 20)
    ii23 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice2.id, quantity: 10, unit_price: 30)

    ii31 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice3.id, quantity: 10, unit_price: 10)
    ii32 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice3.id, quantity: 10, unit_price: 20)
    ii33 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice3.id, quantity: 10, unit_price: 30)

    t1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: 123456, result: 'success')
    t2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: 123456, result: 'success')
    t3 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: 123456, result: 'failed')

    get "/api/v1/revenue/merchants/#{merchant.id}"

    expect(response).to be_successful

    merchant_data = JSON.parse(response.body, symbolize_names: true)
    revenue_data = merchant_data[:data]

    expect(merchant_data).to have_key(:data)
    expect(merchant_data[:data]).to be_a(Hash)
    expect(revenue_data).to be_a(Hash)
    expect(revenue_data).to have_key(:id)
    expect(revenue_data[:id]).to be_a(String)
    expect(revenue_data).to have_key(:type)
    expect(revenue_data[:type]).to be_a(String)
    expect(revenue_data).to have_key(:attributes)
    expect(revenue_data[:attributes]).to be_a(Hash)
    expect(revenue_data[:attributes]).to have_key(:revenue)
    expect(revenue_data[:attributes][:revenue]).to be_a(Float)
    expect(revenue_data[:attributes][:revenue]).to eq(900.0)
  end
end
