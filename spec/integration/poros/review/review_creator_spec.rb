require 'rails_helper'

RSpec.describe 'Review::ReviewCreator' do
  let(:review_creator) { Review::ReviewCreator }
  let(:support) { create_support }
  let(:writing) { create(:writing, text: 'Hello', language: support.sourceLanguage) }
  let(:review) { Review.new(support: support) }


  describe '#create' do
    context 'the review is valid' do
      context "the support's review has at least 1 translation" do
        let!(:translation) do
          create(:translation, support: review.support,
                               sourceWriting: writing,
                               targetWriting: writing,
                               context: '')
        end

        it 'should create a review' do
          expect(review_creator.create(review).persisted?).to eq true
        end

        it "should set the mark of the support's review to 0" do
          expect(review_creator.create(review).support.mark).to eq 0
        end

        it 'should create 1 question with the review' do
          expect(review_creator.create(review).questions.count).to eq 1
        end
      end

      context 'the review has no translation at all' do
        it 'should not create a review' do
          expect(review_creator.create(review).persisted?).to eq false
        end

        context 'the support has a mark of 5' do
          before do
            support.update(mark: 5)
          end
          it "should not set the mark of the support's review to 0" do
            expect(review_creator.create(review).support.mark).to eq 5
          end
        end

        it 'should not create any question with the review' do
          expect(review_creator.create(review).questions.count).to eq 0
        end
      end
    end

    context 'the review is not valid' do
      before do
        allow(review).to receive(:valid?) { false }
      end

      it 'should not create a review' do
        expect(review_creator.create(review).persisted?).to eq false
      end
      context 'the support has a mark of 5' do
        before do
          support.update(mark: 5)
        end
        it "should not set the mark of the support's review to 0" do
          expect(review_creator.create(review).support.mark).to eq 5
        end
      end
    end
  end
end
