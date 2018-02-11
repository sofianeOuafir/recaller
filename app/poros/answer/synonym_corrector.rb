class Answer::SynonymCorrector
  def self.correct?(answer)
    Writing::SynonymsFinder.find_synonyms_of(answer.question.writing).include?(answer.writing)
  end
end
