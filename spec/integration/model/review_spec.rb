require 'rails_helper'

RSpec.describe Review, type: :integration do
  describe '#create_with_questions' do
    context 'The support we want to create the review from has no translation' do
      it 'should not create a review'
    end

    context 'The support we want to create the review from has 2 translations' do
      it 'should create a review with 2 question'
    end
  end
end
