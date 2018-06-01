require 'rails_helper'

RSpec.describe Questions::Generator, type: :unit do
  let(:french) { instance_double(Language, name: 'french') }
  let(:english) { instance_double(Language, name: 'english') }
  let(:source) { instance_double(Writing, text: 'bonjour', language: french) }
  let(:target) { instance_double(Writing, text: 'hello', language: english) }
  let(:translation) { instance_double(Translation, sourceWriting: source, targetWriting: target) }
  describe '#process' do
    context 'it generates a question in a non reverse way (from source to target)' do
      before do
        @generator = Questions::Generator.new(translation, reverse: false)
        @formats = [
          "What is the meaning of \"#{source.text}\" in #{english.name}",
          "What is the #{english.name} for \"#{source.text}\"",
          "If I tell you \"#{source.text}\", what do you understand?",
          "In #{english.name}, how do we say \"#{source.text}\"?",
          "Do you know how to say \"#{source.text}\" in #{english.name}?",
          "Write down the definition of \"#{source.text}\" in #{english.name}?",
          "Do you recall what \"#{source.text}\" means in #{english.name}?"
        ]
      end
      it 'should generate the right question' do
        question = @generator.process
        expect(@formats).to include question
      end 
    end

    context 'it generate a question in a reverse way (from target to source)' do
      before do
        @generator = Questions::Generator.new(translation, reverse: true)
        @formats = [
          "What is the meaning of \"#{target.text}\" in #{french.name}",
          "What is the #{french.name} for \"#{target.text}\"",
          "If I tell you \"#{target.text}\", what do you understand?",
          "In #{french.name}, how do we say \"#{target.text}\"?",
          "Do you know how to say \"#{target.text}\" in #{french.name}?",
          "Write down the definition of \"#{target.text}\" in #{french.name}?",
          "Do you recall what \"#{target.text}\" means in #{french.name}?"
        ]
      end

      it 'should generate the right question' do
        question = @generator.process
        expect(@formats).to include question
      end
    end
  end
end
