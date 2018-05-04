require 'rails_helper'

RSpec.describe Reviews::QuestionsCreator, type: :unit do
  let(:translations) { [build_stubbed(:translation), build_stubbed(:translation), build_stubbed(:translation)] }
  let(:question_creator) { class_double(Questions::Creator) }
  let(:review) { instance_double(Review) }
  describe '#create_questions' do
    context 'the method receive an array of 3 translations as an argument' do
      before do
        allow(question_creator).to receive(:process)
      end
      it 'should create 3 questions' do
        expect(question_creator).to receive(:process).thrice
        Reviews::QuestionsCreator.new(review: review, question_creator: question_creator).create_questions(translations: translations)
      end 
    end
  end
end
