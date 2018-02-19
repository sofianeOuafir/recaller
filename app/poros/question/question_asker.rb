class Question::QuestionAsker

  def self.ask(review)
    next_question(review)
  end

  def self.finish?(review)
    review.questions.count == already_asked_question_ids(review).size
  end

  private_class_method

  def self.next_question(review)
    remaining_questions(review).first
  end

  def self.remaining_questions(review)
    review.questions.where.not(id: already_asked_question_ids(review))
  end

  def self.already_asked_question_ids(review)
    review.answers.correct.map(&:question_id).uniq
  end
end
