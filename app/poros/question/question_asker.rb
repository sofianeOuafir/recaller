class Question::QuestionAsker

  def self.ask(review)
    @review = review
    next_question
  end

  private_class_method

  def self.next_question
    not_correctly_answered = @review.questions.not_correctly_answered
    random_number = rand(0..not_correctly_answered.size - 1)
    @review.questions.not_correctly_answered[random_number]
  end
end
