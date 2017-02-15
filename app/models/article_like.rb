class ArticleLike < ActiveRecord::Base
  belongs_to :article, counter_cache: :likes_count
  belongs_to :user

  validates :user_id
  validates :article_id, presence: true, uniqueness: { scope: [:user_id] }
end
