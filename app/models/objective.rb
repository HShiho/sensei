class Objective < ApplicationRecord

  belongs_to :goal

  enum period_genre: {
    month: 0,
    week: 1,
    day: 2
  }

end
