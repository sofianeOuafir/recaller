require 'rails_helper'

RSpec.describe Writings::Creator, type: :integration do
  let!(:language) { create(:language, :french) }
  describe '#process' do
    context 'the data are valid' do
      before do
        @text = 'Bonjour'
        @language_id = language.id
      end
      context 'trying to create a word that do not exist in the db' do
        it 'should create a new writing' do
          Writings::Creator.process(text: @text, language_id: @language_id)
          expect(Writing.where(text: @text, language_id: @language_id).count).to eq 1
        end
      end

      context 'trying to create a word that do exist in the db' do
        before { @bonjour = Writings::Creator.process(text: @text, language_id: @language_id) }

        it 'should not create a new writing' do
          Writings::Creator.process(text: @text, language_id: @language_id)
          expect(Writing.where(text: @text, language_id: @language_id).count).to eq 1
        end

        it 'should return the word that is already in the db' do
          @word = Writings::Creator.process(text: @text, language_id: @language_id)
          expect(@word).to eq @bonjour
        end
      end
    end

    context 'the data are not valid' do
      before do
        @text = ''
        @language_id = nil
      end

      it 'should return an unpersisted word' do
        word = Writings::Creator.process(text: @text, language_id: @language_id)
        expect(word).not_to be_persisted
      end
    end
  end
end
