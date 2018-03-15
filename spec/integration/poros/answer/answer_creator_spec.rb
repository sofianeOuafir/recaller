require 'rails_helper'

RSpec.describe Answer::AnswerCreator, type: :integration do
  let(:answer_creator) { class_double('Answer::AnswerCreator') }
  let(:review) { create_review }
  let(:writing) { create(:writing, text:'Hello', language: review.support.sourceLanguage) }
  let(:translation) do
    create(:translation, support: review.support,
                         sourceWriting: writing,
                         targetWriting: writing,
                         context: '')
  end
  let(:question) { create(:question, review: review, translation: translation, writing: writing) }
  let!(:question2) { create(:question, review: review, translation: translation, writing: writing, correctly_answered: true) }
  let!(:answer2) { create(:answer, writing: writing, review: review, question: question2, correct: true) }

  before do
    allow(answer_creator).to receive(:create).with(kind_of(Answer))
  end

  describe '#create' do
    context 'A user has given an answer to a question' do
      context 'the answer is valid' do
        context 'the answer is correct' do
          before do
            @answer = Answer.new(
              writing: writing,
              review_id: review.id,
              question_id: question.id
            )
          end

          it 'should create an answer' do
            answer = Answer::AnswerCreator.create(@answer)
            expect(answer.persisted?).to eq true
            expect(answer.correct?).to eq true
          end

          it "should set the answer's question as correctly answered" do
            answer = Answer::AnswerCreator.create(@answer)
            expect(answer.question.correctly_answered).to eq true
          end

          it 'should re-calculate the mark' do
            answer = Answer::AnswerCreator.create(@answer)
            expect(answer.review.mark).to eq 5.0
          end

          it "should re-calculate the support's mark" do
            answer = Answer::AnswerCreator.create(@answer)
            expect(answer.review.support.mark).to eq 5.0
          end

          context 'the review is complete' do
            it 'it should set the review as complete' do
              answer = Answer::AnswerCreator.create(@answer)
              expect(answer.review.complete).to eq true
            end
          end


          context 'the review is not complete' do
            before do
              review.questions << create(:question, review: review, translation: translation, writing: writing)
            end
            it 'it should not set the review as complete' do
              answer = Answer::AnswerCreator.create(@answer)
              expect(answer.review.complete).to eq false
            end
          end
        end

        context 'the answer is not correct' do
          before do
            @answer = Answer.new(
              writing: create(:writing, text:'Hellooooo', language: review.support.sourceLanguage),
              review_id: review.id,
              question_id: question.id
            )
          end

          it 'should create an answer' do
            answer = Answer::AnswerCreator.create(@answer)
            expect(answer.persisted?).to eq true
            expect(answer.correct?).to eq false
          end

          it 'should re-calculate the mark' do
            answer = Answer::AnswerCreator.create(@answer)
            expect(answer.review.mark).to eq 2.5
          end

          it "should re-calculate the support's review mark" do
            answer = Answer::AnswerCreator.create(@answer)
            expect(answer.review.support.mark).to eq 2.5
          end

          it "should not set the answer's question as correctly answered" do
            answer = Answer::AnswerCreator.create(@answer)
            expect(answer.question.correctly_answered).to eq false
          end

          it "should not set the review as complete" do
            answer = Answer::AnswerCreator.create(@answer)
            expect(answer.review.complete).to eq false
          end
        end
      end

      context 'the answer is invalid' do
        before do
          @invalid_answer = Answer.new(
            writing: writing,
            review_id: review.id,
            question_id: question.id
          )
          allow(@invalid_answer).to receive(:valid?) { false }
        end

        it 'should not create an answer' do
          expect(Answer::AnswerCreator.create(@invalid_answer).persisted?).to eq false
        end

        it "should not set the answer's question as correctly answered" do
          expect(Answer::AnswerCreator.create(@invalid_answer).question.correctly_answered?).to eq false
        end

        it "should not set the review as complete" do
          expect(Answer::AnswerCreator.create(@invalid_answer).review.complete).to eq false
        end

        it 'should not calculate the mark' do
          expect(Answer::AnswerCreator.create(@invalid_answer).review.mark).to eq 0.0
        end

        it "should not calculate support's review mark" do
          expect(Answer::AnswerCreator.create(@invalid_answer).review.support.mark).to eq 0.0
        end

        it 'correct column should remain nil' do
          expect(Answer::AnswerCreator.create(@invalid_answer).correct).to eq nil
        end
      end
    end
  end
end
