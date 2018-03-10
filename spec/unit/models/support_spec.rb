require 'rails_helper'

RSpec.describe Support, type: :unit do
  let(:subject) { build_stubbed(:support) }

  describe '#reviewable? method' do
    context 'A support that contains translations' do
      before { allow(subject.translations).to receive(:present?) { true } }
      it 'is reviewable' do
        expect(subject.reviewable?).to eq true
      end
    end

    context 'A support that do not contains any translation' do
      before { allow(subject.translations).to receive(:present?) { false } }
      it 'is not reviewable' do
        expect(subject.reviewable?).to eq false
      end
    end
  end

  describe '#languages_updatable?' do
    context 'The support has at least 1 translations' do
      before do
        create_translation
        @relation = Translation.all
        allow(subject).to receive(:translations) { @relation }
      end

      it 'should return false' do
        expect(subject.languages_updatable?).to eq false
      end
    end

    context 'The support has no translations' do
      it 'should return true' do
        expect(subject.languages_updatable?).to eq true
      end
    end
  end
end
