FactoryGirl.define do
  factory :group do
    name       Faker::Company.name
    body       Faker::Company.catch_phrase
    private    Faker::Boolean.boolean
    manager_id Faker::Number.number(2)
  end
end
