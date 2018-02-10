class Review < ApplicationRecord
  belongs_to :support
  has_many :questions
  has_many :answers


  def self.create_with_questions(support)
    review = support.reviews.create
    Question::QuestionsCreator.new(review: review).create_questions
    review
  end

  def number_of_questions
    questions.count
  end
end
