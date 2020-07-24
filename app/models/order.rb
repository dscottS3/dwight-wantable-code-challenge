class Order < ApplicationRecord
  self.per_page = 10

  BUILDING = "building"
  ARRIVED = "arrived"
  CANCELED = "canceled"
  STATES = [BUILDING, ARRIVED, CANCELED].freeze

  validates_presence_of :user_id, :state

  validates   :total,
              presence: true,
              format: {
                with: /\A-?\d+\.?\d{0,2}\z/,
                message: 'only accepts 2 decimal places.'
              }

  belongs_to :user
  belongs_to :address

  has_many :order_items
  has_many :payments

  delegate :name, to: :user, prefix: true
  delegate :email, to: :user, prefix: true

  # loop over STATES constant to create corresponding scopes and a couple of
  # convenience methods
  STATES.each do |the_state|
    scope "#{the_state}", -> { where(state: the_state) }
    define_method("#{the_state}?".to_sym) { the_state == state }
    define_method("#{the_state}!".to_sym) { update(state: the_state) }
  end

  def to_param
    number
  end

  def self.search(query)
    query.strip!

    results = where(number: query).or(where(id: query))
    return results unless results.blank?

    results = joins(:user).where(users: { email: query })
    return results unless results.blank?

    results = joins(:user).where(users: { name: query })
    return results unless results.blank?

    like_query = 'users.email like ? or users.name like ?'
    results = joins(:user).where(like_query, "%#{query}%", "%#{query}%")

    results
  end

  def color_class
    return 'info' if building?
    return 'danger' if canceled?
    return 'success' if arrived?
  end
end
