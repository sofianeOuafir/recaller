require 'rails_helper'

RSpec.describe Support, type: :unit do
  let(:support) { build_stubbed(:support) }

  describe '#reviewable?' do
    context 'the method is called with a collection of many translations' do
      it 'is reviewable' do
        translations = [Translation.new, Translation.new]
        expect(support.reviewable?(translations: translations)).to eq true
      end
    end

    context 'the method is called with an empty collection of translations' do
      it 'is not reviewable' do
        translations = []
        expect(support.reviewable?(translations: translations)).to eq false
      end
    end

    context 'the method is called without any argument' do
      it 'should send a message to the Translations::FetchAll object' do
        expect(Translations::FetchAll).to receive(:process)
        support.reviewable?
      end
    end
  end

  describe '#languages_updatable?' do
    context 'The support has at least 1 translations' do
      before do
        create_translation
        @relation = Translation.all
        allow(support).to receive(:translations) { @relation }
      end

      it 'should return false' do
        expect(support.languages_updatable?).to eq false
      end
    end

    context 'The support has no translations' do
      it 'should return true' do
        expect(support.languages_updatable?).to eq true
      end
    end
  end
end
