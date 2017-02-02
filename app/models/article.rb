class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :stocks, dependent: :destroy
  acts_as_taggable
  acts_as_taggable_on :labels

  def is_stocked?(user)
    Stock.exists?(user_id: user.id, article_id: self.id)
  end

  def related_stock(user)
    return self.stocks.find_by(user_id: user.id)
  end

end
