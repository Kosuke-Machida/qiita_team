FactoryGirl.define do
  factory :user do
    username   'testname'
    slack_name '@test'
    email      'test@finc.com'
    password   'testpass'
  end
end
