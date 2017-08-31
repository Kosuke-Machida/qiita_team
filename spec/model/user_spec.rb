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
  describe 'instance methods' do
    describe 'belonging_groups_without_master' do
      # 入っているグループが渡されること
      it "includes group which user joinde in" do
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

    describe 'not_belonging_groups' do
      # ユーザーがまだ入っていないグループを含むこと
      it "incliudes group which user hasn't joined" do
        user = create(:user)
        group = create(:group)
        groups = user.not_belonging_groups
        expect(groups).to include(group)
      end

      # ユーザーがすでに参加しているグループを含まないこと
      it "doesn't include group which user joined" do
        user = create(:user)
        group = create(:group)
        create(:group_user, user: user, group: group)
        groups = user.not_belonging_groups
        expect(groups).not_to include(group)
      end
    end

    describe "not_belinging_public_groups" do
      # ユーザーがまだ入っていないpublicグループを含むこと
      it "incliudes public group which user hasn't joined" do
        user = create(:user)
        group = create(:group, private: false)
        groups = user.not_belonging_public_groups
        expect(groups).to include(group)
      end

      # ユーザーがすでに参加しているグループを含まないこと
      it "doesn't include group which user joined" do
        user = create(:user)
        group = create(:group)
        create(:group_user, user: user, group: group)
        groups = user.not_belonging_public_groups
        expect(groups).not_to include(group)
      end

      # privateグループを含まないこと
      it "doesn't include private group which user hasn't joined" do
        user = create(:user)
        group = create(:group, private: true)
        groups = user.not_belonging_public_groups
        expect(groups).not_to include(group)
      end
    end

    describe "has_alredy_joined_in_this_group?" do
      it "returns true when user joined master group" do
        user = create(:user)
        expect(user.has_alredy_joined_in_this_group?).to eq(true)
      end

      it "returns false when user hasn't joined master group" do
        user = create(:user)
        GroupUser.find_by(user_id: user.id, group_id: Group::MASTER_GROUP_ID).destroy
        expect(user.has_alredy_joined_in_this_group?).to eq(false)
      end
    end
  end

  describe 'scope' do
    describe 'serched_by_name' do
      it "returns user whose name is same as keyword" do
        user = create(:user, username: 'Qiitateam Test')
        searched_user = User.searched_by_name('Qiitateam Test')
        expect(searched_user).to include(user)
      end
    end

    describe 'group_manger' do
      it "returns manager when given the group" do
        user = create(:user)
        group = create(:group, manager_id: user.id)
        manager = User.group_manager(group.id)
        expect(manager).to include(user)
      end
    end
  end
end
