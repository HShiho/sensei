class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :post

  self.inheritance_column = :_type_disabled

  enum type: {
    nice: 0,
    like: 1,
    fight: 2
  }

end
