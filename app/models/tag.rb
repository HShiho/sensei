class Tag < ApplicationRecord

  has_many :post_tags,  dependent: :destroy
  has_many :posts,  through: :post_tags,  dependent: :destroy
  has_many :topic_tags,  dependent: :destroy

  # 空白NG
  validates :name, presence: true
  # 重複NG
  validates :name, uniqueness: true

end
