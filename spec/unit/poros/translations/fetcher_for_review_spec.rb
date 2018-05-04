require 'rails_helper' 

RSpec.describe Translations::FetcherForReview do
  let(:review) { instance_double(Review) }
  describe '#process' do
    before do
      allow(review).to receive(:not_deleted_translations)
    end

    it 'should fetch the right translations for the given review' do
      expect(review).to receive(:not_deleted_translations)
      Translations::FetcherForReview.process(review)
    end
  end
end