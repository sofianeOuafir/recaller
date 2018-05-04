class Reviews::ReviewCompleter
  def self.mark_review_as_complete_if_complete(review)
    @review = review
    return if @review.complete?
    @review.update(complete: true) if review_is_complete?
  end

  private_class_method

  def self.review_is_complete?
    @review.questions.count == @review.questions.correctly_answered.count
  end
end
