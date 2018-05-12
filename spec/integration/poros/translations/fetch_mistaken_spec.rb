require 'rails_helper'

RSpec.describe Translations::FetchMistaken do
  let(:revision) { spy(Review) }
  describe '#process' do
    it 'should fetch the translations that have been mistaken' do
      # Translations::FetchMistaken.process(support)
      # expect(support).to have_received(:translations_mistaken_in_last_revision)
    end
  end
end
