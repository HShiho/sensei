class Inquiry < ApplicationRecord

  belongs_to :user

  enum subject: {
    question: 0,
    plese_delete: 1,
  }

end
