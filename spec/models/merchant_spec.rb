require 'rails_helper'

describe Merchant do
  describe 'validations' do
    it { should validate_presence_of :name }
  end
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  before :each do
    @merchants = create_list(:merchant, 5)
    @item1 = Item.create!(
      name: 'one',
      description: 'one again',
      unit_price: 10.0,
      merchant_id: @merchants.first.id
    )
    @item2 = Item.create!(
      name: 'two',
      description: 'two again',
      unit_price: 20.0,
      merchant_id: @merchants.second.id
    )
    @item3 = Item.create!(
      name: 'three',
      description: 'three again',
      unit_price: 30.0,
      merchant_id: @merchants.third.id
    )

    @merchants.first.items << @item1
    @merchants.second.items << @item2
    @merchants.third.items << @item3

    @customer = Customer.create!(first_name: 'first',
                                last_name: 'last')

    @invoice1 = Invoice.create!(customer_id: @customer.id,
                                merchant_id: @merchants.first.id,
                                status: 'shipped')

    @invoice2 = Invoice.create!(customer_id: @customer.id,
                                merchant_id: @merchants.second.id,
                                status: 'shipped')

    @invoice3 = Invoice.create!(customer_id: @customer.id,
                                merchant_id: @merchants.third.id,
                                status: 'shipped')

    ii11 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 24, unit_price: 10)
    ii12 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 17, unit_price: 20)
    ii13 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 65, unit_price: 30)

    ii21 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice2.id, quantity: 48, unit_price: 10)
    ii22 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 99, unit_price: 20)
    ii23 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice2.id, quantity: 12, unit_price: 30)

    ii31 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice3.id, quantity: 68, unit_price: 10)
    ii32 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice3.id, quantity: 43, unit_price: 20)
    ii33 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 200, unit_price: 30)

    t1 = Transaction.create!(invoice_id: @invoice1.id, credit_card_number: 123456, result: 'success')
    t2 = Transaction.create!(invoice_id: @invoice2.id, credit_card_number: 123456, result: 'success')
    t3 = Transaction.create!(invoice_id: @invoice3.id, credit_card_number: 123456, result: 'success')
  end

  describe 'total_revenue' do
    it 'retuns the total revenue for a merchant' do
      merchant = @merchants.first

      expect(merchant.total_revenue).to eq(1400.0)
    end
  end
  describe 'most revenue' do
    it 'returns merchants with the most revenue' do
      merchant1 = @merchants.first
      merchant2 = @merchants.second
      merchant3 = @merchants.third

      expect(Merchant.most_revenue(2)).to eq([merchant3, merchant2])
      expect(Merchant.most_revenue(2).first.revenue).to eq(8310.0)
      expect(Merchant.most_revenue(2).second.revenue).to eq(3180.0)
    end
  end
  describe 'most_items_sold' do
    it 'returns mercahnts with the most items sold' do
      merchant1 = @merchants.first
      merchant2 = @merchants.second
      merchant3 = @merchants.third

      expect(Merchant.most_items_sold(2)).to eq([merchant3, merchant2])
      expect(Merchant.most_items_sold(2).first.sold_items).to eq(277)
      expect(Merchant.most_items_sold(2).second.sold_items).to eq(159)
    end
  end
end
