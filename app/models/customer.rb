class Customer < ApplicationRecord
  before_save { self.first_name = first_name.downcase }
  before_save { self.last_name = last_name.downcase }
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
end
