class Question::QuestionsCreator
  attr_reader :review

  def initialize(args)
    @review = args[:review]
  end

  def create_questions
    review.support.translations.each do |translation|
      Question::QuestionGenerator.new(translation: translation, review: review).generate
    end
  end
end
