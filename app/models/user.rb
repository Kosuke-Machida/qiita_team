class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  validates :username, presence: true, uniqueness: true
  validates :slack_name,
            format: { presence: true,
                      with: /\@/,
                      message: 'should start with @' }
  validates :email,
            format: { with: /\@finc\.com/,
                      message: 'should be from finc.com' }

  scope :searched_by_name, ->(keyword) { where('username LIKE(?)', "%#{keyword}%") }
  scope :group_manager, ->(group_manager_id) { find_by('id = ?', group_manager_id) }

  def belonging_groups_without_master
    groups - [Group.find(MASTER_GROUP_ID)]
  end

  def not_belonging_groups
    Group.all - groups
  end

  def not_belonging_public_groups
    not_belonging_groups.select { |group| group.private == false }
  end

  def has_already_joined_in_master_team?
    GroupUser.where(user_id: id, group_id: MASTER_GROUP_ID).exist?
  end

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :stocks, dependent: :destroy

  has_many :group_users
  has_many :groups, through: :group_users

  has_many :article_likes, dependent: :destroy
end
