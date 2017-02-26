FactoryGirl.define do
  factory :user do
    username   Faker::Internet.user_name
    slack_name "@" + Faker::Internet.user_name
    email      Faker::Internet.user_name + "test@finc.com"
    password   Faker::Internet.password(8)

    # master_groupを自動でcreateして紐付ける
    after(:create) do |user|
      group = create(:group, id: Group::MASTER_GROUP_ID)
      create(:group_user, user: user, group: group )
    end
  end
end
