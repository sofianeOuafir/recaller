require 'rails_helper'

RSpec.describe Questions::Asker, type: :unit do
  let(:question1) { instance_double(Question) }
  let(:question2) { instance_double(Question) }
  let(:picker) { Questions::Picker }
  let(:review) { instance_double(Review) }
  let(:asker) { Questions::Asker.new(review: review, questions: fetcher, picker: picker) }

  context 'questions is not empty' do
    before { @questions = [question1, question2] }

    it 'should return either question1 or question2' do
      asker =  Questions::Asker.new(review: review, questions: @questions, picker: picker)
      question = asker.process
      expect(@questions).to include(question)
    end
  end

  context 'questions is empty' do
    before { @questions = [] }

    it 'should return nil' do
      asker =  Questions::Asker.new(review: review, questions: @questions, picker: picker)
      question = asker.process
      expect(question).to be_nil
    end
  end
end
