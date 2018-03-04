class Review < ApplicationRecord
  belongs_to :support
  has_many :questions
  has_many :answers


  def self.create_with_questions(support)
    return if support.translations.empty?
    review = support.reviews.create
    Question::QuestionsCreator.new(review: review).create_questions
    review
  end

  def number_of_questions
    questions.count
  end

  def mark
    return 0 if questions.empty?
    return 0 if answers.empty?
    calculate_mark
  end

  def complete?
    complete == true
  end

  def incomplete?
    complete == false
  end

  private

  def calculate_mark
    round_point_5((number_of_correct_answers.to_f / number_of_questions.to_f) * 100 / 20)
  end

  def round_point_5(float)
    (float * 2).round / 2.0
  end

  def number_of_correct_answers
    questions.where.not(id: ids_of_questions_answered_incorrectly).where(id: ids_of_questions_answered).count
  end

  def ids_of_questions_answered_incorrectly
    answers.incorrect.map(&:question_id)
  end

  def ids_of_questions_answered
    answers.map(&:question_id)
  end
end
