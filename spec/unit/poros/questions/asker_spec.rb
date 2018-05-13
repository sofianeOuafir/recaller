require 'rails_helper'

RSpec.describe Questions::Asker, type: :unit do
  let(:fetcher) { class_double(Questions::FetcherForReview) }
  let(:picker) { class_double(Questions::Picker) }
  let(:review) { instance_double(Review) }
  let(:asker) { Questions::Asker.new(review: review, fetcher: fetcher, picker: picker) }

  before do
    allow(picker).to receive(:process)
    allow(fetcher).to receive(:process)
  end

  it 'should ask the fetcher to fetch the question' do
    expect(fetcher).to receive(:process)
    asker.process
  end

  it 'should ask the picker to pick a question' do
    expect(picker).to receive(:process)
    asker.process
  end
end
