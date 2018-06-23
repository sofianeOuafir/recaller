class Question < ApplicationRecord
  belongs_to :review
  belongs_to :translation
  belongs_to :writing
  has_many :answers

  scope :correctly_answered, -> { where(correctly_answered: true) }

  def expected_answer
    writing
  end

  def about
    return translation.targetWriting if reverse?
    translation.sourceWriting
  end
end
