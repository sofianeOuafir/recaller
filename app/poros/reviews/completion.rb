module Reviews
  class Completion
    def initialize(review, questions_left: Questions::NotCorrectlyAnswered.process(review.questions))
      @review = review
      @questions_left = questions_left
    end

    def percentage
      return if review.questions.length.zero?
      (100 - ((questions_left.length.to_f / review.questions.length.to_f) * 100)).round
    end

    private

    attr_reader :review, :questions_left
  end
end
