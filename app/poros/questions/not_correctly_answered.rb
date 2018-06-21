class Questions::NotCorrectlyAnswered
  def self.process(questions)
    questions.where(correctly_answered: false)
  end
end
