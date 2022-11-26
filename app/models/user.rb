class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :icon_image

  has_many :goals,  dependent: :destroy
  has_many :posts,  dependent: :destroy
  has_many :post_comments,  dependent: :destroy
  has_many :favorites,  dependent: :destroy
  has_many :inquiries,  dependent: :destroy
  
  
  has_many :follows, class_name: "Follow", foreign_key: "follower_id",  dependent: :destroy
  has_many :reverse_of_follows, class_name: "Follow", foreign_key: "user_id",  dependent: :destroy
  
  has_many :followings, through: :follows, source: :user
  has_many :followers, through: :reverse_of_follows, source: :follower
  # has_many :follows, dependent: :destroy
  # has_many :users, through: :follows

  # 空白NG
  validates :nickname, presence: true
  # メールアドレス
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  # 一意性
  validates :email, uniqueness: true
  validates :encrypted_password, uniqueness: true

  # ゲストログイン
  def self.guest
    find_or_create_by!(email: 'guest@sample.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = "ゲストユーザー"
    end
  end

  # ユーザーアイコン画像表示
  def get_icon_image(width, height)
    unless icon_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      icon_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      icon_image.variant(resize_to_limit: [width, height]).processed
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

  def withdrawal_or_valibity
    "#{is_deleted ? '退会' : '有効'}"
  end

  def self.find_user(id)
    User.find(id)
  end

end
