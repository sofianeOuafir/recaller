require 'rails_helper'

RSpec.describe 'Answer::SpellingCorrector class', type: :unit do
  let(:language) { build_stubbed(:language, :french) }
  let(:writing) { build_stubbed(:writing, text: 'Maison', language: language) }
  let(:question) { build_stubbed(:question, writing: writing) }
  let(:answer) { build_stubbed(:answer, writing: writing, question: question) }

  describe 'Correct? method' do
    context 'the spelling of the answer is correct' do
      it 'return true' do
        result = Answer::SpellingCorrector.correct?(answer)
        expect(result).to eq true
      end
    end

    context 'the spelling of the answer is not correct' do
      it 'return false' do
        answer.writing = build_stubbed(:writing, text: 'maiso', language: language)
        expect(Answer::SpellingCorrector.correct?(answer)).to eq false
      end
    end

    context 'the answer given as an argument is nil' do
      it 'return false' do
        answer = nil
        expect(Answer::SpellingCorrector.correct?(answer)).to eq false
      end
    end
  end
end
