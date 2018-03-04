require 'rails_helper'

RSpec.describe Question, type: :unit do
  let(:hello) { build_stubbed(:writing) }
  let(:bonjour) { build_stubbed(:writing) }
  let(:translation) { build_stubbed(:translation, sourceWriting: hello, targetWriting: bonjour) }
  let(:question) { build_stubbed(:question, writing: hello, translation: translation) }

  describe '#expected_answer method' do
    it 'returns question.writing' do
      expect(question.expected_answer).to eq question.writing
    end
  end

  describe '#about method' do
    context 'when the question is asked normally' do
      before { question.reverse = false }
      it 'the method return the source of the translation' do
        expect(question.about).to eq question.translation.sourceWriting
      end
    end

    context 'when the question is reversed' do
      before { question.reverse = true }
      it 'the method return the target of the translation' do
        expect(question.about).to eq question.translation.targetWriting
      end
    end
  end
end
