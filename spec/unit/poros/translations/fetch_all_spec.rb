require 'rails_helper'

RSpec.describe Translations::FetchAll do
  let(:support) { spy(Support) }
  describe 'process' do
    it 'should fetch all translations not deleted belonging to the review' do
      Translations::FetchAll.process(support)
      expect(support).to have_received(:all_translations_not_deleted)
    end
  end
end
