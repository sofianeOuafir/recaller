require 'rails_helper'

RSpec.describe Writings::Creator, type: :unit do
  let(:text) { 'Bonjour' }
  let(:language_id) { 'fr' }
  let(:model) { spy(Writing, find_or_create: nil) }
  let(:creator) { Writings::Creator.new(text: text, language_id: language_id, model: model) }
  describe 'process' do
    it 'should find or create a writing' do
      creator.process
      expect(model).to have_received(:find_or_create_by).with(hash_including(text: text, language_id: language_id))
    end
  end
end

