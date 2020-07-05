FactoryBot.define do
  factory :parking_ticket do
    in_at { Time.zone.now - 25.minutes }
    car

    trait :paid do
      paid { true }
    end

    trait :left do
      paid
      out_at { Time.zone.now }
    end
  end
end
