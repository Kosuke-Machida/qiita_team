class Group < ActiveRecord::Base
  has_many :group_users
  has_many :users, through: :group_users
  has_many :articles, dependent: :destroy
  has_one :manager

  validates :name, presence: true
  validates :body, presence: true
  validates :manager_id, presence: true

  MASTER_GROUP_ID = 1

  def relation_with_user(user)
    group_users.find_by(user_id: user.id)
  end

  def joined_by_this_user?(user)
    GroupUser.exists?(user_id: user.id, group_id: id)
  end

  def self.without_master_joined_by(user)
    user.groups - [ find(MASTER_GROUP_ID) ]
  end
end
