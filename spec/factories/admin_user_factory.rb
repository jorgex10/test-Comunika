FactoryBot.define do
  factory :admin_user do
    email { Faker::Internet.email }
    password { Faker::Crypto.md5 }
  end
end
