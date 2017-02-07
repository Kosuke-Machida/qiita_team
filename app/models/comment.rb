class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  has_many :comment_likes, dependent: :destroy

  def user_like(user_id)
    self.comment_likes.find_by(user_id: user_id)
  end

  validates :body, presence: true
  validates :user_id, presence: true
  validates :article_id, presence: true

end
