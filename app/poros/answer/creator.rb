class Answer::Creator
  def self.create(answer)
    @answer = answer
    return @answer unless @answer.valid?
    @answer.correct = Answer::AnswerCorrector.new.correct?(@answer)
    return @answer unless @answer.save
    recalculate_supports_mark
    recalculate_reviews_mark
    return @answer unless @answer.correct?
    set_question_as_correctly_answered
    set_review_as_complete_if_complete
    @answer
  end

  private_class_method

  def self.recalculate_reviews_mark
    @answer.review.update(mark: Reviews::MarkCalculator.calculate(@answer.review))
  end

  def self.recalculate_supports_mark
    @answer.review.support.update(mark: Reviews::MarkCalculator.calculate(@answer.review))
  end

  def self.set_question_as_correctly_answered
    @answer.question.update(correctly_answered: true)
  end

  def self.set_review_as_complete_if_complete
    Reviews::ReviewCompleter.mark_review_as_complete_if_complete(@answer.review)
  end
end
