class Reviews::QuestionsCreator
  attr_reader :review

  def initialize(review:, question_creator: Questions::Creator, translations_fetcher: Translations::Fetcher)
    @review = review
    @question_creator = question_creator
    @translation_fetcher = translations_fetcher
  end

  def create_questions(translations: @translation_fetcher.process(review))
    translations.each do |translation|
      @question_creator.process(translation: translation, review: review)
    end
  end
end
