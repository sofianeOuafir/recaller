require 'rails_helper'

RSpec.describe 'Translation::TranslationCreator' do
  let(:review) { create_review }
  let(:writing) { create(:writing, text:'Hello', language: review.support.sourceLanguage) }

  describe '#create' do
    context 'The translation is valid' do
      before do
        @translation = Translation.new(support: review.support,
                                       sourceWriting: writing,
                                       targetWriting: writing,
                                       context: '')
      end

      it 'should create a translation' do
        expect(Translation::TranslationCreator.create(@translation).persisted?).to eq true
      end

      context 'The review has a mark of 5' do
        before do
          review.update(mark: 5)
        end

        it "should recalculate the review's mark" do
          pending 'need to be implemented'
          translation = translation_creator.create(translation)
          expect(translation.review.mark).to eq 0
        end
      end
    end

    context 'The translation is not valid' do
      before do
        allow(translation).to receive(:valid?) { false }
      end

      it 'should not create a translation' do
        pending 'need to be implemented'
        translation = translation_creator.create(translation)
        expect(translation.persisted?).to eq false
      end

      context 'The review has a mark of 5' do
        before do
          review.update(mark: 5)
        end

        it "should not recalculate the review's mark" do
          pending 'need to be implemented'
          translation = translation_creator.create(translation)
          expect(translation.review.mark).to eq 5
        end
      end
    end
  end
end
