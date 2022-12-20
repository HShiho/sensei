FactoryBot.define do
  factory :topic do
    title { Faker::Lorem.characters(number:10)}
  end
end