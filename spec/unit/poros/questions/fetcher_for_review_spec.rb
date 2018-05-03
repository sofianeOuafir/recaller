require 'rails_helper'

RSpec.describe Questions::FetcherForReview do
  let(:review) { instance_double(Review) }
  it 'should fetch all questions that have not been answered correctly in a review' do
    expect(review).to receive(:not_correctly_answered_questions)
    Questions::FetcherForReview.process(review)
  end
end