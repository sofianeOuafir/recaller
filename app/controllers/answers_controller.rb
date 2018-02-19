class AnswersController < ApplicationController
  def create
    @answer = Answer.new(answer_params)
    @answer.writing = Writing.find_or_create_by(text: params[:answer][:text],
                                                language_id: @answer.question.expected_answer.language_id)
    @answer.correct = Answer::AnswerCorrector.correct?(@answer)
    @answer.save
    @review = @answer.review
  end

  def new
    review = Review.find(params[:review_id])
    @question = Question::QuestionAsker.ask(review)
    @answer = @question.answers.new
  end

  private

  def answer_params
    params.require(:answer)
          .permit(:question_id, :review_id)
  end
end
