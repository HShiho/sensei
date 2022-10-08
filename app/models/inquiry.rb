class Inquiry < ApplicationRecord

  belongs_to :user

  enum subject: {
    question: 0,
    plese_delete: 1,
  }

  # 空白NG
  validates :body, presence: true
  # メールアドレス
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :reply_mail, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  # 一意性
  validates :reply_mail, uniqueness: true

end
