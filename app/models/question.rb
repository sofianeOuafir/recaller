class Question < ApplicationRecord
  belongs_to :review
  belongs_to :translation
  belongs_to :writing
  has_many :answers

  def about
    translation.sourceWriting
  end
end
