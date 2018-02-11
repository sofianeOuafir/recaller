class Answer::SpellingCorrector
  def self.correct?(answer)
    answer.question.writing == answer.writing
  end
end
