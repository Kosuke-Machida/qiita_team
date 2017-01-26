class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :stocks, dependent: :destroy

  has_many :article_likes, dependent: :destroy
  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end


  acts_as_taggable
  acts_as_taggable_on :labels
end
