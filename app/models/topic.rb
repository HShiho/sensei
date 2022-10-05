class Topic < ApplicationRecord

  has_many :topic_comments, dependent: :destroy
  has_many :topic_tags, dependent: :destroy
  has_many :tags,  through: :topic_tags,  dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :topic_comments

end
