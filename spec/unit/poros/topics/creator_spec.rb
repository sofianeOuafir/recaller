require 'rails_helper'

RSpec.describe Topics::Creator, type: :unit do
  let(:topic) { instance_double(Support, save: true) }
  let(:translations) { [instance_double(Translation), instance_double(Translation)] }
  let(:duplicator) { class_double(Translations::Duplicator, process: nil) }
  describe '#process' do
    before do 
      allow(Support).to receive(:new).and_return(topic) 
    end
    context 'create a topic with a valid name and some translations' do
      let(:creator) do 
        Topics::Creator.new(
          params: { name: 'my Topic' }, 
          translations: translations,
          duplicator: duplicator
        ) 
      end
      it 'should create a topic' do
        expect(topic).to receive(:save)
        creator.process
      end

      it 'should duplicate translations in the created topic' do
        expect(duplicator).to receive(:process)
        creator.process
      end
    end

    context 'create a topic with a valid name and no translations' do
      let(:creator) do 
        Topics::Creator.new(
          params: { name: 'my Topic' }, 
          duplicator: duplicator
        ) 
      end
      it 'should create a topic' do
        expect(topic).to receive(:save)
        creator.process
      end

      it 'should try to duplicate translations in the created topic' do
        expect(duplicator).not_to receive(:process)
        creator.process
      end
    end
  end
end