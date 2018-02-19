class Question::QuestionGenerator
  attr_reader :translation, :review

  def initialize(args)
    @translation = args[:translation]
    @review = args[:review]
  end

  def generate
    if reverse?
      generate_reverse_question
    else
      generate_normal_question
    end
  end

  private

  def reverse?
    rand(0..1).zero?
  end

  def generate_reverse_question
    Question.create(review_id: review.id,
                    translation_id: translation.id,
                    question: "Quel est la definition du mot '#{translation.targetWriting.text}' en #{translation.sourceWriting.language.name} ?",
                    writing_id: translation.sourceWriting.id,
                    reverse: true)
  end

  def generate_normal_question
    Question.create(review_id: review.id,
              translation_id: translation.id,
              question: "Quel est la definition du mot '#{translation.sourceWriting.text}' en #{translation.targetWriting.language.name} ?",
              writing_id: translation.targetWriting.id,
              reverse: false)
  end

end
