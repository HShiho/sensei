class Goal < ApplicationRecord
  
  has_many :objectives,  dependent: :destroy
  belongs_to :user
  
end
