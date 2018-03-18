class ReviewsController < ApplicationController
  def create
    support = Support.find(params[:support_id])
    @review = Review::ReviewCreator.create(support.reviews.build)
  end
end
