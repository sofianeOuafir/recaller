require 'rails_helper'

RSpec.describe 'Answer::AnswerCorrector class', type: :unit do
  let(:synonym_corrector) { class_double('Answer::SynonymCorrector') }
  let(:spelling_corrector) { class_double('Answer::SpellingCorrector') }
  let(:answer_corrector) { Answer::AnswerCorrector.new(correctors: [synonym_corrector, spelling_corrector]) }
  let(:language) { build_stubbed(:language, :french) }
  let(:writing) { build_stubbed(:writing, text: 'Maison', language: language) }
  let(:question) { build_stubbed(:question, writing: writing) }
  let(:answer) { build_stubbed(:answer, writing: writing, question: question) }

  before do
    allow(spelling_corrector).to receive(:correct?)
    allow(synonym_corrector).to receive(:correct?)
  end

  describe '#correct? method' do
    context 'the spelling is correct' do
      before do
        allow(spelling_corrector).to receive(:correct?).with(answer).and_return(true)
      end

      it 'should return true' do
        expect(answer_corrector.correct?(answer)).to eq true
      end
    end

    context 'the spelling is not correct but the answer given is a synonym of the expected answer' do
      before do
        allow(spelling_corrector).to receive(:correct?).with(answer).and_return(false)
        allow(synonym_corrector).to receive(:correct?).with(answer).and_return(true)
      end

      it 'should return true' do
        expect(answer_corrector.correct?(answer)).to eq true
      end
    end

    context 'the spelling is not correct and the answer given is not a synonym of the expected answer' do
      before do
        allow(spelling_corrector).to receive(:correct?).with(answer).and_return(false)
        allow(synonym_corrector).to receive(:correct?).with(answer).and_return(false)
      end

      it 'should return false' do
        expect(answer_corrector.correct?(answer)).to eq false
      end
    end
  end
end

