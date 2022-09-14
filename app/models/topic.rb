class Topic < ApplicationRecord
  
  has_many :topic_comments,  dependent: :destroy
  has_many :topic_tags,  dependent: :destroy
  belongs_to :user
  
end
