FactoryBot.define do
  factory :order do
    association :user, factory: :user
    association :address, factory: :address

    state { Order::STATES.sample }
    total { Faker::Number.decimal(l_digits: (1..3).to_a.sample) }
    number { "M#{Faker::Number.number}" }

    trait :building do
      state { Order::BUILDING }
    end

    trait :arrived do
      state { Order::ARRIVED }
    end

    trait :canceled do
      state { Order::CANCELED }
    end
  end
end
