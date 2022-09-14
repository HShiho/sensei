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

  # ゲストログイン
  def self.guest
    find_or_create_by!(email: 'guest@sample.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = "ゲストユーザー"
    end
  end

end
