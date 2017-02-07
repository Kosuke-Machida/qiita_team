class CommentLike < ActiveRecord::Base
  belongs_to :comment, counter_cache: :likes_count
  belongs_to :user
end
