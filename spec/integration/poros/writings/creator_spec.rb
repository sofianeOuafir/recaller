require 'rails_helper'

RSpec.describe Writings::Creator, type: :integration do
  let!(:language) { create(:language, :french) }
  describe '#process' do
    context 'trying to create a word that do not exist in the db' do
      it 'should create a new writing' do
        Writings::Creator.new(text: 'Bonjour', language_id: language.id).process
        expect(Writing.where(text: 'Bonjour', language_id: language.id).count).to eq 1
      end
    end

    context 'trying to create a word that do exist in the db' do
      before { @bonjour = Writings::Creator.new(text: 'Bonjour', language_id: language.id).process }

      it 'should not create a new writing' do
        Writings::Creator.new(text: 'Bonjour', language_id: language.id).process
        expect(Writing.where(text: 'Bonjour', language_id: language.id).count).to eq 1
      end

      it 'should return the word that is already in the db' do
        @word = Writings::Creator.new(text: 'Bonjour', language_id: language.id).process
        expect(@word).to eq @bonjour
      end
    end
  end
end
