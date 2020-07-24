class OrderItem < ApplicationRecord
  SOLD = "sold"
  RETURNED = "returned"
  STATES = [SOLD, RETURNED].freeze
  validates_presence_of :order_id, :source_id, :source_type, :price

  validates :state,
            absence: true,
            if: -> { source_type != Product.name }

  validates :state,
            allow_nil: false,
            inclusion: STATES,
            if: -> { source_type == Product.name && order.building_at.present? }

  validates :quantity,
            presence: true,
            numericality: {
              greater_than: 0
            }

  belongs_to :order
  belongs_to :source,
             polymorphic: true

  scope :between, ->(dates) {
    where(order_items: { created_at: (dates[0]..dates[1]) })
  }
  #
  # loop over STATES constant to create corresponding scopes and a couple of
  # convenience methods
  STATES.each do |the_state|
    scope "#{the_state}", -> { where(state: the_state) }
    define_method("#{the_state}?".to_sym) { the_state == state }
    define_method("#{the_state}!".to_sym) { update(state: the_state) }
  end
end
