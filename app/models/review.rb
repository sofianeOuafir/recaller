class Review < ApplicationRecord
  belongs_to :support
  has_many :questions
  has_many :answers

  def number_of_questions
    questions.count
  end

  def not_correctly_answered_questions
    questions.not_correctly_answered
  end

  def complete?
    complete == true
  end

  def incomplete?
    complete == false
  end
end
