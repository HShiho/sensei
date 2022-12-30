FactoryBot.define do
  factory :goal do
    title { Faker::Lorem.characters(number:3)}
  end
end