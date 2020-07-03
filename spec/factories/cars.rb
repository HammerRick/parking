FactoryBot.define do
  factory :car do
    model { 'Landau' }
    brand { 'Ford' }
    color { 'Blue' }
    sequence(:plate, 1000) { |n| "AAA-#{n}" }
  end
end
