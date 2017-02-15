class ArticleLike < ActiveRecord::Base
  belongs_to :article, counter_cache: :likes_count
  belongs_to :user

  validates :user_id, presence: true
  validates :article_id, presence: true, uniqueness: { scope: [:user_id] }
end
