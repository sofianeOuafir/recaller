require 'rails_helper'

RSpec.describe Reviews::QuestionsCreator, type: :unit do
  let(:translations) do
    [build_stubbed(:translation),
     build_stubbed(:translation),
     build_stubbed(:translation)]
  end
  let(:question_creator) { class_double(Questions::Creator) }
  let(:translations_fetcher) { class_double(Translations::Fetcher) }
  let(:review) { instance_double(Review, support: nil) }
  let(:questions_creator) do
    Reviews::QuestionsCreator.new(review: review,
                                  question_creator: question_creator,
                                  translations_fetcher: translations_fetcher)
  end


  describe '#create_questions' do
    context 'the method receive an array of 3 translations as an argument' do
      before do
        allow(question_creator).to receive(:process)
        allow(translations_fetcher).to receive(:process) { [] }
      end

      it 'should send a message to the translations_fetcher to get the translations' do
        expect(translations_fetcher).to receive(:process)
        questions_creator.create_questions
      end

      it 'should call the question creator to create 3 questions' do
        expect(question_creator).to receive(:process).thrice
        questions_creator.create_questions(translations: translations)
      end
    end
  end
end
