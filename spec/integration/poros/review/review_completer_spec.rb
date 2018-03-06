require 'rails_helper'

RSpec.describe Review::ReviewCompleter, type: :integration do
  let(:review_completer) { class_double('Review::ReviewCompleter') }
  let(:review) { create_review }
  let(:writing) { create(:writing, text:'Hello', language: review.support.sourceLanguage) }
  let(:translation) do
    create(:translation, support: review.support,
                         sourceWriting: writing,
                         targetWriting: writing,
                         context: '')
  end

  before do
    allow(review_completer).to receive(:mark_review_as_complete_if_complete)
      .with(review)
  end

  describe '#mark_review_as_complete_if_complete' do
    context 'The review is not set as complete yet' do
      before do
        review.questions << create(:question, review: review, translation: translation, writing: writing)
      end
      context 'all questions have been answered correctly' do
        before do
          review.questions.first.update(correctly_answered: true)
        end

        it 'should set the review as complete' do
          Review::ReviewCompleter.mark_review_as_complete_if_complete(review)
          expect(review.complete).to eq true
        end
       end

       context 'not all questions have been answered correctly' do
        it 'should not set the review as complete' do
          Review::ReviewCompleter.mark_review_as_complete_if_complete(review)
          expect(review.complete).to eq false
        end
       end
    end

    context 'The review is complete' do
      before do
        allow(review).to receive(:complete) { true }
      end

      it 'should not try to set the review as complete' do
        expect(review).not_to receive(:update)
        Review::ReviewCompleter.mark_review_as_complete_if_complete(review)
      end
    end
  end
end
