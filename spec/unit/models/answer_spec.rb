require 'rails_helper'

RSpec.describe Answer, type: :unit do
  let(:writing) { build_stubbed(:writing) }
  let(:question) { build_stubbed(:question, writing: writing) }
  let(:answer) { build_stubbed(:answer, question: question, writing: writing) }

  describe '#answer_given method' do
    it 'returns writing' do
      expect(answer.answer_given).to eq answer.writing
    end
  end

  describe '#correct_with_synonym? method' do
    context 'the answer is correct' do
      before { answer.correct = true }
      context 'and the answer given is the expected answer' do
        it 'should return false' do
          expect(answer.correct_with_synonym?).to eq false
        end
      end

      context 'and the answer given is not the expected answer' do
        it 'should return true' do
          allow(answer).to receive(:answer_given) { nil }
          expect(answer.correct_with_synonym?).to eq true
        end
      end
    end

    context 'the answer is not correct' do
      before { answer.correct = false }
      it 'should return false' do
        expect(answer.correct_with_synonym?).to eq false
      end
    end
  end
end
