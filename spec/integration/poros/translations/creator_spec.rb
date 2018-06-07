require 'rails_helper'

RSpec.describe Translations::Creator, type: :integration do
  let(:review) { create_review }
  let(:writing) { create(:writing, text:'Hello', language: review.support.sourceLanguage) }

  describe '#create' do
    before do
      @params = { support_id: review.support.id,
                  sourceWriting_id: writing.id,
                  targetWriting_id: writing.id,
                  context: '' }
    end
    context 'The translation is valid' do
      it 'should create a translation' do
        expect(Translations::Creator.create(@params).persisted?).to eq true
      end

      context 'The support has a mark of 5' do
        before do
          @translation.support.update(mark: 5)
        end

        it "should recalculate the support's mark" do
          expect(Translations::Creator.create(@params).support.mark).to eq 0
        end
      end
    end

    context 'The translation is not valid' do
      before do
        allow(@translation).to receive(:valid?) { false }
      end

      it 'should not create a translation' do
        expect(Translations::Creator.create(@translation).persisted?).to eq false
      end

      context 'The support has a mark of 5' do
        before do
          @translation.support.update(mark: 5)
        end

        it "should not recalculate the support's mark" do
          expect(Translations::Creator.create(@translation).support.mark).to eq 5
        end
      end
    end
  end
end
