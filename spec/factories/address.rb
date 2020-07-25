FactoryBot.define do
  factory :address do
    association :user, factory: :user

    address1 { Faker::Address.street_address }
    city { Faker::Address.city }
    state  { Faker::Address.state_abbr }
    zipcode { Faker::Address.zip_code.first(5) }
  end
end
