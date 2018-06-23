class AnswersController < ApplicationController
  def create
    # TODO call of Writing::Creator should be done within Answer::Creator
    answer = Answer.new(answer_params)
    answer.writing = Writings::Creator.process(text: params[:answer][:text],
                                              language_id: answer.question.expected_answer.language_id)
    @answer = Answer::Creator.create(answer)
    @review = @answer.review
    @percentage_completed = Reviews::Completion.new(@review).percentage
    return if @review.complete?
    @appreciation = Teacher.appreciation(@answer)
    @question = Questions::Asker.new(review: @review).process
    @new_answer = @question.answers.new
  end

  def new
    review = Review.find(params[:review_id])
    @question = Questions::Asker.new(review: review).process
    @answer = @question.answers.new
    @percentage_completed = Reviews::Completion.new(review).percentage
  end

  private

  def answer_params
    params.require(:answer)
          .permit(:question_id, :review_id)
  end
end
