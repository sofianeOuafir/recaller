class Answer::SpellingCorrector
  def self.correct?(answer)
    return false if answer.nil?
    answer.question.expected_answer == answer.answer_given
  end
end
