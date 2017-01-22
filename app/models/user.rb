class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   attr_accessor :name



  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :group_users
  has_many :groups, through: :group_users

end
