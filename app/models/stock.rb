class Stock < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

  validates :user_id, presence: true
  validates :article_id, presence: true
end
