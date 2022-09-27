class Goal < ApplicationRecord

  has_many :objectives,  dependent: :destroy
  belongs_to :user

  enum is_completed: {
    not_completed: 0,
    completed: 1,
  }

end
