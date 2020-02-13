# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  3.times do
    Community.create!(name: Faker::Company.name, subdomain: Faker::Internet.domain_word)
  end
  community = Community.first
  # User.create(community: community, name: Faker::Name.name, email: Faker::Internet.email, role: 'tenant')
  # User.create(community: community, name: Faker::Name.name, email: Faker::Internet.email, role: 'owner')
  # User.create(community: community, name: Faker::Name.name, email: Faker::Internet.email, role: 'manager')

  users = [
    {
      community: community,
      name: 'Jorge Calvo',
      email: 'jorgeecg10@gmail.com',
      contact_number: '+51972052891',
      role: 'tenant'
    },
    {
      community: community,
      name: Faker::Name.name,
      email: Faker::Internet.email,
      contact_number: '+51972052891',
      role: 'owner'
    },
    {
      community: community,
      name: Faker::Name.name,
      email: Faker::Internet.email,
      contact_number: '+51972052891',
      role: 'manager'
    }
  ]
  User.create(users)
end