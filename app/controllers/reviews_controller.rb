class ReviewsController < ApplicationController
  def create
    support = Support.find(params[:support_id])
    @review = Reviews::ReviewCreator.create(support.reviews.build)
  end
end
