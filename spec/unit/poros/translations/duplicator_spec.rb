require 'rails_helper'

RSpec.describe Translations::Duplicator do
  let(:translations) do 
    [instance_double(Translation, context: 'myContext', targetWriting_id: nil, sourceWriting_id: nil), 
     instance_double(Translation, context: 'myContext', targetWriting_id: nil, sourceWriting_id: nil), 
     instance_double(Translation, context: 'myContext', targetWriting_id: nil, sourceWriting_id: nil)] 
  end
  let(:support) { instance_double(Support, id: nil) }
  let(:translations_creator) { class_double(Translations::Creator) }
  let(:duplicator) do 
    Translations::Duplicator.new(
      translations: translations,
      listable: support,
      translations_creator: translations_creator
    ) 
  end

  describe '#process' do
    context 'duplicate 3 translations into a list' do
      it 'should create 3 translations' do
        expect(translations_creator).to receive(:create).thrice
        duplicator.process
      end
    end
  end
end