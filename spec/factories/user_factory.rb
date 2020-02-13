FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    role { %w[tenant owner manager].sample }
    contact_number { '+51972052891' }

    community
  end
end
