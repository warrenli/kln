require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.name  { Faker::Name.name }
Sham.email { Faker::Internet.email(Faker::Name.first_name) }
Sham.title { Faker::Lorem.sentence }
Sham.body  { Faker::Lorem.paragraph }

User.blueprint do
  email { Sham.email }
  password "password"
  password_confirmation "password"
  time_zone "Hong Kong"
end

Post.blueprint do
  title  { Sham.title }
  body   { Sham.body }
  published_on 5.days.ago
  user
end

Comment.blueprint do
  post
  email  { Sham.email }
  author { Sham.name }
  body   { Sham.body}
end

Order.blueprint do
  customer        { Sham.name }
  currency        "USD"
  price           101.99
  delivered       false
  expiration_date Date.today
end

Task.blueprint do
  description { Sham.title }
  priority    "Low"
  due_on      Date.today
end

