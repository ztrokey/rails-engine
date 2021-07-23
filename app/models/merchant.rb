# frozen_string_literal: true

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

  def self.most_revenue(limit)
    joins(invoice_items: { invoice: :transactions })
      .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
      .group(:id)
      .where(transactions: { result: 'success' }, invoices: { status: 'shipped' })
      .order('revenue desc')
      .limit(limit)
  end

  def self.most_items_sold(limit)
    joins(invoice_items: { invoice: :transactions })
      .select('merchants.*, sum(invoice_items.quantity) as sold_items')
      .group(:id)
      .where(transactions: { result: 'success' }, invoices: { status: 'shipped' })
      .order('sold_items desc')
      .limit(limit)
  end
end
