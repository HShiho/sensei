FactoryBot.define do
  factory :user do
    nickname              {"test"}
    email                 {"test@gmail.com"}
    password              {"111111"}
    password_confirmation {"111111"}
    # nickname { Faker::Name.name(number:5) }
    # email { Faker::Internet.email(number:12) }
    # password { Faker::Lorem.characters(number:7)}
  end
end