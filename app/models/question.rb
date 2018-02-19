class Question < ApplicationRecord
  belongs_to :review
  belongs_to :translation
  belongs_to :writing
  has_many :answers

  def expected_answer
    writing
  end

  def about
    return translation.targetWriting if reverse?
    translation.sourceWriting
  end
end
