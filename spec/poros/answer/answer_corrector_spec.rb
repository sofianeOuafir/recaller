require 'rails_helper'

RSpec.describe 'Answer::AnswerCorrector class', type: :poro do
  let(:language) { build_stubbed(:language, :french) }
  let(:writing) { build_stubbed(:writing, text: 'Maison', language: language) }
  let(:question) { build_stubbed(:question, writing: writing) }
  let(:answer) { build_stubbed(:answer, writing: writing, question: question) }

  describe '#correct? method' do
    it 'Answer::SpellingCorrector should receive correct?' do
      expect(Answer::SpellingCorrector).to receive(:correct?)
      Answer::AnswerCorrector.correct?(answer)
    end

    it 'Answer::SynonymCorrector should receive correct?' do
      expect(Answer::SynonymCorrector).to receive(:correct?)
      Answer::SynonymCorrector.correct?(answer)
    end
  end
end

