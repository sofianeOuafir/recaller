require 'rails_helper'

RSpec.describe Questions::Creator, type: :unit do
  let(:answer) { instance_double(Writing, id: 1) }
  let(:translation) { instance_double(Translation, id: 1) }
  let(:review) { instance_double(Translation, id: 2) }
  let(:question_generator) do 
    instance_double(Questions::Generator, process: 'wanna be my friend?', reverse: true, answer: answer) 
  end

  describe '#process' do
    it 'should create a question' do
      expect(Question).to receive(:create).with(hash_including(review_id: review.id, translation_id: translation.id, question: 'wanna be my friend?', reverse: true, writing_id: answer.id))
      Questions::Creator.process(
        translation: translation,
        review: review,
        question_generator: question_generator
      )
    end
  end
end
