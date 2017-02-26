FactoryGirl.define do
  factory :article do
    title: Faker::Book.title
    body: 'samplesamplesampletesttesttest'
    user
  end
end
