class CommentLike < ActiveRecord::Base
  belongs_to :comment, counter_cache: :likes_count
  belongs_to :user

  validates :user_id, presence: true
  validates :group_id, presence: true, uniqueness: { scope: [:user_id] }
end
