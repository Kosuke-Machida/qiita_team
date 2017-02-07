class ArticleLike < ActiveRecord::Base
  belongs_to :article, counter_cache: :likes_count
  belongs_to :user
end
