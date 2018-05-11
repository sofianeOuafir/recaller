require 'rails_helper'

RSpec.describe Translations::FetchMistaken do
  let(:support) { spy(Support) }
  describe '#process' do
    it 'should fetch the translations that have been mistaken in last revision' do
      Translations::FetchMistaken.process(support)
      expect(support).to have_received(:translations_mistaken_in_last_revision)
    end
  end
end