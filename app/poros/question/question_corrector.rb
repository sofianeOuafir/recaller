class Question::QuestionCorrector

  def self.correct?(answer)
    correct_answer?(answer) || answer_is_synonym?(answer)
  end

  private_class_method

  def self.correct_answer?(answer)
    answer.question.writing == answer.writing
  end

  def self.answer_is_synonym?(answer)
    Writing::SynonymsFinder.find(answer.question.writing).include?(answer.writing)
  end

end
