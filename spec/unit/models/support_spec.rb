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
end
