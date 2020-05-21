class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :merchant_id

  attribute :unit_price do |object|
    object.unit_price / 100
  end

  attribute :description do |object|
    object.description.capitalize
  end

  attribute :name do |object|
    object.name.capitalize
  end

  belongs_to :merchant
  has_many :invoice_items
end
