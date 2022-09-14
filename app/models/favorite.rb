class Favorite < ApplicationRecord
  
  belongs_to :user
  belongs_to :post
  
  enum favoite_type: {
    nice: 0,
    like: 1,
    fight: 2
  }
  
end
