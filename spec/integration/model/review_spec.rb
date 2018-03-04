require 'rails_helper'

RSpec.describe Review, type: :integration do
  describe '#create_with_questions' do
    context 'The support we want to create the review from has no translation' do
      it 'should not create a review'
    end

    context 'The support we want to create the review from 2 translations' do
      it 'should create a review with 2 question'
    end
  end

  describe '#mark' do
    let(:review) { create_review }
    let(:writing) { create(:writing, text:'Hello', language: review.support.sourceLanguage) }
    let(:translation) do
      create(:translation, support: review.support,
                           sourceWriting: writing,
                           targetWriting: writing,
                           context: '')
    end

    context 'The review has 0 questions' do
      it 'should return 0' do
        expect(review.mark).to eq 0
      end
    end

    context 'The review has 7 questions' do
      before do
        review.questions << create(:question, review: review, translation: translation, writing: writing)
        review.questions << create(:question, review: review, translation: translation, writing: writing)
        review.questions << create(:question, review: review, translation: translation, writing: writing)
        review.questions << create(:question, review: review, translation: translation, writing: writing)
        review.questions << create(:question, review: review, translation: translation, writing: writing)
        review.questions << create(:question, review: review, translation: translation, writing: writing)
        review.questions << create(:question, review: review, translation: translation, writing: writing)
      end

      context 'The user has responded to 0 questions' do
        it 'should return 0' do
          expect(review.mark).to eq 0
        end
      end

      context 'the user has not completed the review' do
        context 'The user has answered only 2 questions' do
          before do
            answer1 = create(:answer, review: review, writing: writing, correct: true, question: review.questions.first)
            review.answers << answer1
            answer2 = create(:answer, review: review, writing: writing, correct: true, question: review.questions.second)
            review.answers << answer2
          end

          context 'without any mistake' do
            it 'should return the right mark' do
              expect(review.mark).to eq 1.5
            end
          end

          context 'with 1 mistake' do
            before do
              review.answers.first.update(correct: false)
            end

            it 'should return the right mark' do
              expect(review.mark).to eq 0.5
            end
          end
        end
      end

      context 'The user has completed the review' do
        context 'The user gave 2 wrong answer concerning 2 different questions' do
          before do
            answer1a = create(:answer, review: review, writing: writing, correct: false, question: review.questions.first)
            review.answers << answer1a
            answer1b = create(:answer, review: review, writing: writing, correct: true, question: review.questions.first)
            review.answers << answer1b
            answer2 = create(:answer, review: review, writing: writing, correct: false, question: review.questions.second)
            review.answers << answer2
            answer3 = create(:answer, review: review, writing: writing, correct: true, question: review.questions.third)
            review.answers << answer3
            answer4 = create(:answer, review: review, writing: writing, correct: true, question: review.questions.fourth)
            review.answers << answer4
            answer5 = create(:answer, review: review, writing: writing, correct: true, question: review.questions.fifth)
            review.answers << answer5
            answer6 = create(:answer, review: review, writing: writing, correct: true, question: review.questions.order(id: :desc).second)
            review.answers << answer6
            answer7 = create(:answer, review: review, writing: writing, correct: true, question: review.questions.last)
            review.answers << answer7
          end
          it 'should return the right mark' do
            expect(review.mark).to eq 3.5
          end
        end
      end
    end
  end
end
