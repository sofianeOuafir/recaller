require 'rails_helper'

RSpec.describe Questions::Picker, type: :unit do
  let(:questions) { [build_stubbed(:question), build_stubbed(:question)] }
  describe '#process' do
    it 'should return a question randomly' do
      question = Questions::Picker.process(questions)
      expect(question).to be_a_kind_of(Question)
    end
  end
end
