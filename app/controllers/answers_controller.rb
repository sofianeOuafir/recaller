class AnswersController < ApplicationController
  def create
    @answer = Answer.new(answer_params)
    @answer.correct = Answer::AnswerCorrector.new(answer: answer).correct?
    @answer.save
  end

  def new
    review = Review.find(params[:review_id])
    @question = Question::QuestionAsker.new(review: review).ask
    @answer = @question.answers.new
  end

  private

  def answer_params
    params.require(:answer)
          .permit(:answer, :question_id, :review_id)
  end
end
