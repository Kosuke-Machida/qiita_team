class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :stocks, dependent: :destroy

  has_many :article_likes, dependent: :destroy
  def liked_by_this_user(user_id)
    article_likes.find_by(user_id: user_id)
  end


  acts_as_taggable
  acts_as_taggable_on :labels

  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true


  def is_stocked?(user)
    Stock.exists?(user_id: user.id, article_id: self.id)
  end

  def related_stock(user)
    return self.stocks.find_by(user_id: user.id)
  end

end
