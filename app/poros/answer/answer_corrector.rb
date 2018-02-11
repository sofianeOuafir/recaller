class Answer::AnswerCorrector
  def self.correct?(answer)
    Answer::SpellingCorrector.correct?(answer) ||
      Answer::SynonymCorrector.correct?(answer)
  end
end
