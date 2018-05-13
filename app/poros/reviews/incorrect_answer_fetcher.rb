class Reviews::IncorrectAnswerFetcher 
  def self.process(revision)
    revision.answers.incorrect
  end
end
