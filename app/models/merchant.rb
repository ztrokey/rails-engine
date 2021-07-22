class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def total_revenue
    invoice_items.joins(invoice: :transactions)
                 .where(transactions: { result: 'success' }, invoices: { status: 'shipped' })
                 .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end
