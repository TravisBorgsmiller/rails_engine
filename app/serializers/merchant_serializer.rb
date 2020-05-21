class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id

  attribute :name do |object|
    object.name.capitalize
  end

  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
end
