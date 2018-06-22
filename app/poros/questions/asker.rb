class Questions::Asker
  def initialize(review:, questions: Questions::NotCorrectlyAnswered.process(review.questions), picker: Questions::Picker)
    @questions = questions
    @picker = picker
  end

  def process
    return if questions.empty?
    picker.process(questions)
  end

  private

  attr_reader :questions, :picker
end
