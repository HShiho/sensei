class Post < ApplicationRecord

  has_one_attached :image

  has_many :post_comments,  dependent: :destroy
  has_many :post_tags,  dependent: :destroy
  has_many :favorites,  dependent: :destroy
  belongs_to :user

  enum achivement: {
    excellence: 0,
    good: 1,
    almost: 2
  }

end
