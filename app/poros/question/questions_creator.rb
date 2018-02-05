class Question::QuestionsCreator
  attr_reader :review

  def initialize(args)
    @review = args[:review]
  end

  def create_questions
    review.support.translations.each do |translation|
      question = Question::QuestionGenerator.new(translation: translation).generate
      Question.create(review_id: review.id,
                      translation_id: translation.id,
                      question: question)
    end
  end
end
