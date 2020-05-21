class Merchant < ApplicationRecord
  before_save { self.name = name.downcase }
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

end
