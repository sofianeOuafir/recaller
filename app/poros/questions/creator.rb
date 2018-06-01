class Questions::Creator
  attr_reader :review

  def self.process(translation:, review:, question_generator: Questions::Generator.new(translation))
    Question.create(
      review_id: review.id,
      translation_id: translation.id,
      question: question_generator.process,
      writing_id: question_generator.answer.id,
      reverse: question_generator.reverse
    )
  end
end
