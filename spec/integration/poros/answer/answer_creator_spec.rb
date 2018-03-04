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

  before do
    allow(answer_creator).to receive(:create).with(kind_of(ActionController::Parameters))
  end

  describe '#create' do
    context 'A user has given an answer to a question' do
      context 'the answer is valid' do
        context 'the answer is correct' do
          before do
            @answers_params = ActionController::Parameters.new({
              answer: {
                question_id: question.id,
                review_id: review.id,
                text: 'Hello'
              }
            })
          end

          it 'should create an answer' do
            @answer = Answer::AnswerCreator.create(@answers_params)
            expect(@answer.persisted?).to eq true
          end

          it "should set the answer's question as correctly answered" do
            @answer = Answer::AnswerCreator.create(@answers_params)
            expect(@answer.question.correctly_answered).to eq true
          end

          context 'the review is complete' do
            it 'it should set the review as complete' do
              @answer = Answer::AnswerCreator.create(@answers_params)
              expect(@answer.review.complete).to eq true
            end
          end


          context 'the review is not complete' do
            before do
              review.questions << create(:question, review: review, translation: translation, writing: writing)
            end
            it 'it should not set the review as complete' do
              @answer = Answer::AnswerCreator.create(@answers_params)
              expect(@answer.review.complete).to eq false
            end
          end
        end

        context 'the answer is not correct' do
          before do
            @answers_params = ActionController::Parameters.new({
              answer: {
                question_id: question.id,
                review_id: review.id,
                text: 'Helloooo'
              }
            })
          end

          it 'should create an answer' do
            @answer = Answer::AnswerCreator.create(@answers_params)
            expect(@answer.persisted?).to eq true
          end

          it "should not set the answer's question as correctly answered" do
            @answer = Answer::AnswerCreator.create(@answers_params)
            expect(@answer.question.correctly_answered).to eq false
          end

          it "should not set the review as complete" do
            @answer = Answer::AnswerCreator.create(@answers_params)
            expect(@answer.review.complete).to eq false
          end
        end
      end

      context 'the answer is invalid' do
        before do
          @answers_params = ActionController::Parameters.new({
            answer: {
              question_id: 1000,
              review_id: review.id,
              text: 'Helloooo'
            }
          })
        end

        it 'should create an answer' do
        end

        it "should not set the answer's question as correctly answered" do
        end

        it "should not set the review as complete" do
        end
      end
    end
  end
end
