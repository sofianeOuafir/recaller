class Questions::Asker
  def initialize(review:, questions: Questions::NotCorrectlyAnswered.process(review.questions), picker: Questions::Picker)
    @questions = questions
    @picker = picker
  end

  def process
    @picker.process(@questions)
  end
end
