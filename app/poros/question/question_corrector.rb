class Question::QuestionCorrector
  attr_reader :answer

  def initialize(args)
    @answer = args[:answer]
  end

  def correct?
    answer.question.writing.text == answer.text
  end

end
