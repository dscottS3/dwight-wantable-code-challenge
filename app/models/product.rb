class Product < ApplicationRecord
  self.per_page = 10

  validates_presence_of :name

  validates   :sku,
              presence: true,
              uniqueness: true

  validates   :msrp,
              presence: true,
              numericality: {
                greater_than_or_equal_to: 0
              },
              format: {
                with: /\A-?\d+\.?\d{0,2}\z/,
                message: 'only accepts 2 decimal places.'
              }

  validates   :cost,
              presence: true,
              numericality: {
                greater_than_or_equal_to: 0
              },
              format: {
                with: /\A-?\d+\.?\d{0,2}\z/,
                message: 'only accepts 2 decimal places.'
              }

  has_many :order_items,
           as: :source

  scope :with_sales, -> {
    joins(:order_items).where(order_items: { state: OrderItem::SOLD })
  }

  scope :between, ->(dates) {
    joins(:order_items).where(order_items: { created_at: (dates[0]..dates[1]) })
  }
end
