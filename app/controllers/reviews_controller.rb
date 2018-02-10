class ReviewsController < ApplicationController
  def create
    support = Support.find(params[:support_id])
    @review = Review.create_with_questions(support)
  end
end
