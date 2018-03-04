class Answer::AnswerCreator
  def self.create(params)
    @params = params
    @answer = Answer.new(answer_params)
    @answer.writing = Writing.find_or_create_by(text: params[:answer][:text],
                                                language_id: @answer.question.expected_answer.language_id)
    @answer.correct = Answer::AnswerCorrector.new.correct?(@answer)
    return @answer unless @answer.save
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

  def self.answer_params
    @params.require(:answer)
           .permit(:question_id, :review_id)
  end
end
