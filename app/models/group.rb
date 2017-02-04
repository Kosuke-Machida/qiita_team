class Group < ActiveRecord::Base
  has_many :group_users
  has_many :users, through: :group_users

  validates :name, presence: true
  validates :body, presence: true

  def relation_with_user(user)
    return self.group_users.find_by(user_id: user.id)
  end

  def is_joined_by_a_specific_user?(user)
    GroupUser.exists?(user_id: user.id, group_id: self.id)
  end

end
