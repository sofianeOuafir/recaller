require 'rails_helper'

RSpec.describe Questions::NotCorrectlyAnswered, type: :integration do
  let!(:question1) { create(:question) }
  let(:review) { question1.review }

  describe '#filter' do
    context 'the question is incorrectly answered' do
      it 'should only return the questions incorrectly answered' do
        expect(Questions::NotCorrectlyAnswered.filter(review.questions).length).to eq 1
      end
    end

    context 'the question is correctly answered' do
      before { question1.update_columns(correctly_answered: true) }
      
      it 'should only return the questions incorrectly answered' do
        expect(Questions::NotCorrectlyAnswered.filter(review.questions).length).to eq 0
      end
    end
  end
end
