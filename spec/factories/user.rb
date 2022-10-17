FatoryBot.define do
  factory :user do
    nickname { Faker::Name.name(number:5) }
    email { Faker::Internet.email(number:12) }
    password { Faker::Lorem.characters(number:7)}
  end
end