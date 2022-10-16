class TopicComment < ApplicationRecord

  belongs_to :user
  belongs_to :topic
  
  # 空白NG
  validates :body, presence: true

end
