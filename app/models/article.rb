class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  has_many :article_likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :stocks, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true
  validates :user_id, presence: true
  validates :group_id, presence: true

  # グループとの関連付けに関するscope
  scope :available_to, ->(user) { where(group_id: user.groups.map(&:id)) }
  scope :body_include, ->(keyword) { where('body LIKE ?', "%#{keyword}%") }

  # userを引数にして、そのuserがcommentしたarticleを持ってくる
  scope :commented_by, ->(user) { where(id: user.comments.map(&:article_id)) }

  # articleのいいね機能に関するメソッド
  def user_like(user_id)
    article_likes.find_by(user_id: user_id)
  end

  # articleのtag機能に関するメソッド
  acts_as_taggable
  acts_as_taggable_on :labels

  # stockに関するメソッド
  def stocked?(user)
    Stock.exists?(user_id: user.id, article_id: id)
  end

  def related_stock(user)
    stocks.find_by(user_id: user.id)
  end
end
