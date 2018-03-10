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

  def complete?
    complete == true
  end

  def incomplete?
    complete == false
  end
end
