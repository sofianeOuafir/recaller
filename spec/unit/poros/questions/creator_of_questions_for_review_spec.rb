require 'rails_helper'

RSpec.describe Questions::CreatorOfQuestionsForReview, type: :unit do
  let(:translations) { [build_stubbed(:translation), build_stubbed(:translation), build_stubbed(:translation)] }
  let(:question_generator) {  }
  describe '#create_questions' do
    context 'the method receive an array of 3 translations as an argument' do
      it 'should create 3 questions' do

      end 
    end
  end
end
