require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end
  describe 'relationships' do
    it { should belong_to :customer }
    it { should belong_to :merchant }
    it { should have_many :transactions}
    it { should have_many :invoice_items}
    it { should have_many(:items).through(:invoice_items) }
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
                                status: 'packaged')

    @invoice2 = Invoice.create!(customer_id: @customer.id,
                                merchant_id: @merchants.second.id,
                                status: 'packaged')

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
  describe 'unshipped_invoices_potential_revenue' do
    it 'returns invoices with unshipped items' do
      expect(Invoice.unshipped_invoices_potential_revenue(2)).to eq([@invoice2, @invoice1])
      expect(Invoice.unshipped_invoices_potential_revenue(2).first.potential_revenue).to eq(2820.0)
      expect(Invoice.unshipped_invoices_potential_revenue(2).second.potential_revenue).to eq(2530.0)
    end
  end
end
