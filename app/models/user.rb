class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :name

  def not_belonging_groups
    Group.all - self.groups
  end

  def not_belonging_public_groups
    self.not_belonging_groups.select{|group| group.private == false}
  end



  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :stocks, dependent: :destroy

  has_many :group_users
  has_many :groups, through: :group_users
  
  has_many :article_likes, dependent: :destroy

end
