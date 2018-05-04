class Reviews::MarkCalculator
  def self.calculate(review)
    @review = review
    return 0 if @review.questions.empty?
    return 0 if @review.answers.empty?
    calculate_mark
  end

  private_class_method

  def self.calculate_mark
    round_point_5((number_of_correct_answers.to_f / number_of_questions.to_f) * 100 / 20)
  end

  def self.number_of_correct_answers
    @review.questions.where.not(id: ids_of_questions_answered_incorrectly).where(id: ids_of_questions_answered).count
  end

  def self.number_of_questions
    @review.questions.count
  end

  def self.round_point_5(float)
    (float * 2).round / 2.0
  end

  def self.ids_of_questions_answered_incorrectly
    @review.answers.incorrect.map(&:question_id)
  end

  def self.ids_of_questions_answered
    @review.answers.map(&:question_id)
  end
end
