class Item < ApplicationRecord
  before_save { self.name = name.downcase }
  before_save { self.description = description.downcase }
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
end
