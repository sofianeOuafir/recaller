class Review < ApplicationRecord
  belongs_to :support

  def self.create_with_questions(support)
    review = support.reviews.create
    Question::QuestionsCreator.new(review: review).create_questions
  end
end
