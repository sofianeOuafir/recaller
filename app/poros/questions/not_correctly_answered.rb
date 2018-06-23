class Questions::NotCorrectlyAnswered
  def self.filter(questions)
    questions.where(correctly_answered: false)
  end
end
