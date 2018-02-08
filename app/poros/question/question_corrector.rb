class Question::QuestionCorrector

  def self.correct?(answer)
    answer.question.writing.text == answer.text.titleize
    Writing::SynonymsFinder.find
  end

end
