require 'rails_helper'

RSpec.describe Topics::Creator do
  let(:topic) { instance_double(Support, save: nil) }
  let(:translations) { [instance_double(Translation), instance_double(Translation)] }
  describe '#process' do
    before do 
      allow(Support).to receive(:new).and_return(topic) 
    end
    context 'create a topic with a valid name and some translations' do
      let(:creator) { Topics::Creator.new(params: { name: 'my Topic' }, translations: translations) }
      it 'should create a topic' do
        expect(topic).to receive(:save)
        creator.process
      end
    end
  end
end