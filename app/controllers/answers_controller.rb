class AnswersController < ApplicationController
  def create
    @answer = Answer::AnswerCreator.create(params)
    @review = @answer.review
  end

  def new
    review = Review.find(params[:review_id])
    @question = Question::QuestionAsker.ask(review)
    @answer = @question.answers.new
  end
end
