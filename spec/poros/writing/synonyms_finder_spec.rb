require 'rails_helper'

RSpec.describe 'Writing::SynonymsFinder', type: :poro do
  before(:each) do
    allow_any_instance_of(Devise::Mailer).to receive(:confirmation_instructions)
  end

  let!(:french) { create(:language, :french) }
  let!(:english) { create(:language, :english) }
  let!(:hello) { create(:writing, text: 'Hello', language: english) }
  let!(:bonjour) { create(:writing, text: 'Bonjour', language: french) }
  let!(:salut) { create(:writing, text: 'Salut', language: french) }
  let!(:user) { create(:user) }
  let!(:media_type) { create(:media_type, :book) }
  let!(:support) { create(:support, name: 'Harry Potter', user: user, media_type: media_type, sourceLanguage: english, targetLanguage: french)}
  let!(:translation_1) { create(:translation, context: '', sourceWriting: hello, targetWriting: bonjour, support: support)}
  let!(:translation_2) { create(:translation, context: '', sourceWriting: hello, targetWriting: salut, support: support)}

  describe '#find_synonyms_of' do
    it 'salut should be a synoym of bonjour' do
      expect(Writing::SynonymsFinder.find_synonyms_of(bonjour)).to include(salut)
    end
  end
end
