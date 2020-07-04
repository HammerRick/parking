FactoryBot.define do
  factory :parking_ticket do
    in_at { "2020-07-04 14:13:58" }
    out_at { "2020-07-04 14:13:58" }
    paid { false }
    car
  end
end
