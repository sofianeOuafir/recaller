class Questions::FetcherForReview
  def self.process(review)
    review.not_correctly_answered_questions
  end
end
