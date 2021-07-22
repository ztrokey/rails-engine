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
    joins(invoice_items: { invoice: :transactions})
      .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
      .group(:id).where(transactions: { result: 'success' }, invoices: { status: 'shipped' })
      .order('revenue desc')
      .limit(limit)
  end
end

# Category.joins(articles: [{ comments: :guest }, :tags])

# SELECT categories.* FROM categories
#   INNER JOIN articles ON articles.category_id = categories.id
#   INNER JOIN comments ON comments.article_id = articles.id
#   INNER JOIN guests ON guests.comment_id = comments.id
#   INNER JOIN tags ON tags.article_id = articles.id

# trans result: 'success'
# invoice status: 'shipped'
# sum ii.quan * ii.unit_price as rev
# order by rev
# limit by limit

# joins(invoice_items: { invoice: :transactions}).where(transactions: { result: 'success' }, invoices: { status: 'shipped' }).select('merchants.*').sum('invoice_items.quantity * invoice_items.unit_price')


# joins(invoice_items: { invoice: :transactions}).select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue').group(:id).where(transactions: { result: 'success' }, invoices: { status: 'shipped' }).order('revenue desc').limit(limit)