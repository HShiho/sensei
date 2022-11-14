class Post < ApplicationRecord

  has_one_attached :image

  has_many :post_comments,  dependent: :destroy
  has_many :post_tags,  dependent: :destroy
  has_many :tags,  through: :post_tags,  dependent: :destroy
  has_many :favorites,  dependent: :destroy
  belongs_to :user

  enum achivement: {
    excellence: 0,
    good: 1,
    almost: 2
  }

  # 空白NG
  validates :body, presence: true
  validates :tag_ids, presence: true
  # 1文字以上140字以下
  validates :body, length: { in: 1..140 }



  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  

end
