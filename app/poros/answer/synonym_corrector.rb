class Answer::SynonymCorrector
  def self.correct?(answer)
    Writings::SynonymsFinder.find_synonyms_of(answer.question.expected_answer).include?(answer.answer_given)
  end
end
