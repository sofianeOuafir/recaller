class ReviewsController < ApplicationController
  def create
    support = Support.find(params[:support_id])
    @review = Reviews::Creator.process(support: support, what_to_study: params[:what_to_study])
  end
end
