require 'rails_helper'

RSpec.describe Questions::Generator, type: :unit do
  let(:french) { instance_double(Language, name: 'french') }
  let(:english) { instance_double(Language, name: 'english') }
  let(:source) { instance_double(Writing, text: 'bonjour', language: french) }
  let(:target) { instance_double(Writing, text: 'hello', language: english) }
  let(:translation) { instance_double(Translation, sourceWriting: source, targetWriting: target) }
  describe '#process' do
    context 'it generates a question in a non reverse way (from source to target)' do
      before { @generator = Questions::Generator.new(translation, reverse: false) }
      it 'should generate the right question' do
        question = @generator.process
        expect(question).to eq "What is the meaning of 'bonjour' in english ?"
      end 
    end

    context 'it generate a question in a reverse way (from target to source)' do
      before { @generator = Questions::Generator.new(translation, reverse: true) }
      it 'should generate the right question' do
        question = @generator.process
        expect(question).to eq "What is the meaning of 'hello' in french ?"
      end
    end
  end
end
