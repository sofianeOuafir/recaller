class Answer::AnswerCorrector

  def initialize(correctors: [Answer::SpellingCorrector, Answer::SynonymCorrector])
    @correctors = correctors
  end

  def correct?(answer)
    @correctors.each do |corrector|
      return true if corrector.correct?(answer)
    end
    false
  end
end
