require 'rails_helper'

describe User do
  describe 'validation' do
    # username, slack_name, email, passwordが存在すればuserが作成できること
    it "is valid with a username, slack_name, email and password" do
      expect(build(:user)).to be_valid
    end

    # usernameが無いとuserが作成できないこと
    it "is invalid without a username" do
      user = build(:user, username: nil)
      user.valid?
      expect(user.errors[:username]).to include("can't be blank")
    end

    # usernameが重複しているとuserは作成できないこと
    it "is invalid with a duplicate username" do
      userA = create(:user, username: 'testuser')
      userB = build(:user, username: 'testuser')
      userB.valid?
      expect(userB.errors[:username]).to include("has already been taken")
    end

    # slack_nameが無いとuserは作成できないこと
    it "is invalid without a slack_name" do
      user = build(:user, slack_name: nil)
      user.valid?
      expect(user.errors[:slack_name]).to include("can't be blank")
    end

    # slack_nameが無いとuserが作成できないこと
    it "is invalid with a slack_name not including '@'" do
      user = build(:user, slack_name: Faker::Internet.user_name)
      user.valid?
      expect(user.errors[:slack_name]).to include("should start with @")
    end

    # slack_nameが重複しているとuserは作成できないこと
    it "is invalid with a duplicate slack_name" do
      userA = create(:user, slack_name: '@test')
      userB = build(:user, slack_name: '@test')
      userB.valid?
      expect(userB.errors[:slack_name]).to include("has already been taken")
    end

    # emailが無いとuserが作成できないこと
    it "is invalid wihout a email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    # メールドメインがfinc.comでは無いとuserが作成できないこと
    it "is invalid with a email not including '@finc.com'" do
      user = build(:user, email: Faker::Internet.free_email)
      user.valid?
      expect(user.errors[:email]).to include("should be from finc.com")
    end

    # slack_nameが重複しているとuserは作成できないこと
    it "is invalid with a duplicate email" do
      userA = create(:user, email: 'test@finc.com')
      userB = build(:user, email: 'test@finc.com')
      userB.valid?
      expect(userB.errors[:email]).to include("has already been taken")
    end

    # パスワードがないとuserを作成できないこと
    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    # パスワードが6文字以下だとuserを作成できないこと
    it "is invalid with a password less than 6 letters" do
      user = build(:user, password: Faker::Internet.password(1, 5))
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
  end

  describe 'belonging_groups_without_master' do
    # 入っているグループが渡されること
    it "includes groups which user joined" do
      user = create(:user)
      group = create(:group)
      create(:group_user, user: user, group: group)
      groups = user.belonging_groups_without_master
      expect(groups).to include(group)
    end

    # masterグループは含まれていないこと
    it "doesn't include master group" do
      user = create(:user)
      groups = user.belonging_groups_without_master
      expect(groups).to_not include(Group.find(Group::MASTER_GROUP_ID))
    end
  end
end
