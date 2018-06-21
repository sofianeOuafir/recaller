module Reviews
  class Completion
    def initialize(review, questions_left: Questions::NotCorrectlyAnswered.process(review.questions))
      @review = review
      @questions_left = questions_left
    end

    def percentage
      return if review.questions.length.zero?
      ((questions_left.length / review.questions.length) * 100) - 100
    end

    private

    attr_reader :review, :questions_left
  end
end
