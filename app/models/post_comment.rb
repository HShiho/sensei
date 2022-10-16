class PostComment < ApplicationRecord

  belongs_to :user
  belongs_to :post

  # 空白NG
  validates :body, presence: true

end
