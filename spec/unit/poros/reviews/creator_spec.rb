require 'rails_helper'

RSpec.describe Reviews::Creator, type: :unit do
  let(:support) { spy(Support) }
  let(:review) { spy(Review) }
  let(:question_creator) { spy(Questions::Creator) }
  let(:translations) { [double(Translation).as_null_object, double(Translation).as_null_object, double(Translation).as_null_object] }
  let(:translation_fetcher) { spy(Translations::Fetcher) }

  describe '#process' do
    context 'The user wants to revise a support containing 3 translations' do
      it 'should create a revision' do
        Reviews::Creator.process(support: support,
                                 translations: translations,
                                 review: review,
                                 question_creator: question_creator)
        expect(review).to have_received(:save)
      end

      it 'should create 3 questions' do
        Reviews::Creator.process(support: support,
                                 translations: translations,
                                 review: review,
                                 question_creator: question_creator)
        expect(question_creator).to have_received(:process).thrice
      end

      it 'should set the mark of the support to be 0' do
        Reviews::Creator.process(support: support,
                                 translations: translations,
                                 review: review,
                                 question_creator: question_creator)
        expect(support).to have_received(:update).with(hash_including(mark: 0))
      end
    end
  end
end
