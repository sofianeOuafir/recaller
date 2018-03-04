class Answer < ApplicationRecord
  attr_reader :text

  belongs_to :question
  belongs_to :review
  belongs_to :writing

  scope :correct, -> { where(correct: true) }
  scope :incorrect, -> { where(correct: false) }

  def answer_given
    writing
  end

  def correct?
    correct
  end

  def correct_with_synonym?
    return false unless correct?
    answer_given != question.expected_answer
  end
end
