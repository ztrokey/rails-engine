class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.unshipped_invoices_potential_revenue(limit)
    joins(invoice_items: { invoice: :transactions })
      .where.not(status: 'shipped')
      .where(transactions: { result: 'success' })
      .group(:id)
      .select('invoices.*, sum(invoice_items.quantity * invoice_items.unit_price) as potential_revenue')
      .order('potential_revenue DESC')
      .limit(limit)
  end
end
