class Answer < ApplicationRecord
  attr_reader :text

  belongs_to :question
  belongs_to :review
  belongs_to :writing

  def right_answer
    question.writing
  end

  def correct_with_synonym?
    return false unless correct?
    writing != right_answer
  end
end
