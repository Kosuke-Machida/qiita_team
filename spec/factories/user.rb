FactoryGirl.define do
  factory :user do
    username   Faker::Internet.user_name
    slack_name "@" + Faker::Internet.user_name
    email      Faker::Internet.user_name + "test@finc.com"
    password   Faker::Internet.password(8)
  end
end
