class Questions::CreatorOfQuestionsForReview
  attr_reader :review

  def initialize(review:, question_creator: Questions::Creator)
    @review = review
    @question_creator = question_creator
  end

  def create_questions(translations: review.not_deleted_translations)
    translations.each do |translation|
      @question_creator.generate(translation: translation, review: review)
    end
  end
end
