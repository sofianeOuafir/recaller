class Question::QuestionGenerator
  attr_reader :translation, :review

  def initialize(args)
    @translation = args[:translation]
    @review = args[:review]
  end

  def generate
    Question.create(review_id: review.id,
                    translation_id: translation.id,
                    question: "Quel est la definition du mot #{translation.sourceWriting.text} en #{translation.targetWriting.language.name} ?",
                    writing_id: translation.targetWriting.id)
  end
end
