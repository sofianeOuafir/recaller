class Review::ReviewCreator
  def self.create(review)
    @review = review
    return @review unless @review.valid?
    return @review if @review.support.translations.count.zero?
    return @review unless @review.save
    create_questions
    set_support_mark_to_zero
    @review
  end

  private_class_method

  def self.create_questions
    Questions::CreatorOfQuestionsForReview.new(review: @review).create_questions
  end

  def self.set_support_mark_to_zero
    @review.support.update(mark: 0)
  end
end
