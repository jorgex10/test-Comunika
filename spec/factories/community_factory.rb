FactoryBot.define do
  factory :community do
    name { Faker::Name.name }
    subdomain { Faker::Internet.email }
  end
end
