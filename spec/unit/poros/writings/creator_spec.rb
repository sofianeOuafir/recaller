require 'rails_helper'

RSpec.describe Writings::Creator, type: :unit do
  let(:text) { 'Bonjour' }
  let(:language_id) { 'fr' }

  describe 'process' do
    it 'should find or create a writing' do
      expect(Writing).to receive(:find_or_create_by).with(hash_including(text: text, language_id: language_id))
      Writings::Creator.process(text: text, language_id: language_id) 
    end
  end
end

