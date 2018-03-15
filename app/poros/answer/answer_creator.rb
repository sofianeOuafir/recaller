class Answer::AnswerCreator
  def self.create(answer)
    @answer = answer
    return @answer unless @answer.valid?
    @answer.correct = Answer::AnswerCorrector.new.correct?(@answer)
    return @answer unless @answer.save
    @answer.review.support.update(mark: Review::MarkCalculator.calculate(@answer.review))
    @answer.review.update(mark: Review::MarkCalculator.calculate(@answer.review))
    return @answer unless @answer.correct?
    set_question_as_correctly_answered
    set_review_as_complete_if_complete
    @answer
  end

  private_class_method

  def self.set_question_as_correctly_answered
    @answer.question.update(correctly_answered: true)
  end

  def self.set_review_as_complete_if_complete
    Review::ReviewCompleter.mark_review_as_complete_if_complete(@answer.review)
  end
end
