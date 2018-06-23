module Reviews
  class Completion
    def initialize(review)
      raise 'The revision cannot be nil' if review.nil?
      @review = review
    end

    def percentage(questions_left: Questions::NotCorrectlyAnswered.filter(review.questions))
      raise 'The number of questions left cannot be greater than the number of questions in a revision' if questions_left.length > review.questions.length
      return if review.questions.length.zero?
      (100 - ((questions_left.length.to_f / review.questions.length.to_f) * 100)).round
    end

    private

    attr_reader :review
  end
end
