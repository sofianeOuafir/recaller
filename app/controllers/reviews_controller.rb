class ReviewsController < ApplicationController
  def create
    support = Support.find(params[:media_id])
    Review.create_with_questions(support)
  end
end
