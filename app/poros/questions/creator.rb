class Questions::Creator
  attr_reader :review

  def self.generate(translation:, review:)
    if reverse?
      generate_reverse_question(translation: translation, review: review)
    else
      generate_normal_question(translation: translation, review: review)
    end
  end

  private_class_method

  def self.reverse?
    rand(0..1).zero?
  end

  def self.generate_reverse_question(translation:, review:)
    Question.create(review_id: review.id,
                    translation_id: translation.id,
                    question: "What is the meaning of '#{translation.targetWriting.text}' in #{translation.sourceWriting.language.name} ?",
                    writing_id: translation.sourceWriting.id,
                    reverse: true)
  end

  def self.generate_normal_question(translation:, review:)
    Question.create(review_id: review.id,
              translation_id: translation.id,
              question: "What is the meaning of '#{translation.sourceWriting.text}' in #{translation.targetWriting.language.name} ?",
              writing_id: translation.targetWriting.id,
              reverse: false)
  end

end
