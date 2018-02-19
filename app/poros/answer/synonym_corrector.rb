class Answer::SynonymCorrector
  def self.correct?(answer)
    Writing::SynonymsFinder.find_synonyms_of(answer.question.expected_answer).include?(answer.answer_given)
  end
end
