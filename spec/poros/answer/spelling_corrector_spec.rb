require 'rails_helper'

RSpec.describe 'Answer::SpellingCorrector', type: :poro do
  let(:language) { build_stubbed(:language, :french) }
  let(:writing) { build_stubbed(:writing, text: 'Maison', language: language) }
  let(:question) { build_stubbed(:question, writing: writing) }
  let(:answer) { build_stubbed(:answer, writing: writing, question: question) }

  describe '#correct?' do
    context 'the spelling of the answer is correct' do
      it 'should return true' do
        expect(Answer::SpellingCorrector.correct?(answer)).to eq true
      end
    end

    context 'the spelling of the answer is not correct' do
      it 'should return false' do
        answer.writing = build_stubbed(:writing, text: 'maiso', language: language)
        expect(Answer::SpellingCorrector.correct?(answer)).to eq false
      end
    end

    context 'answer.writing is nil' do
      it 'should return false' do
        answer.writing = nil
        expect(Answer::SpellingCorrector.correct?(answer)).to eq false
      end
    end
  end
end
