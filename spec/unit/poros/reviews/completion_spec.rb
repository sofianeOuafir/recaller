require 'rails_helper'

RSpec.describe Reviews::Completion, type: :unit do
  let(:revision) { instance_double(Review) }
  let(:completion) { Reviews::Completion.new(revision)  }

  describe '#percentage' do
    context 'the revision is nil' do
      it 'should throw an error' do
        expect { Reviews::Completion.new(nil) }.to raise_error
      end
    end

    context 'the revision has no questions' do
      before { allow(revision).to receive(:questions) { [] } }
      it 'should return nil' do
        expect(completion.percentage(questions_left: [])).to be_nil
      end
    end

    context 'the revision has 4 questions' do
      before do
        questions = [double(Question), double(Question), double(Question), double(Question)]
        allow(revision).to receive(:questions) { questions }
      end

      context 'they are 1 question left' do
        it 'should return 75' do
          questions_left = [double(Question)]
          expect(completion.percentage(questions_left: questions_left)).to eq 75
        end
      end

      context 'they are 4 questions left' do
        it 'should return 0' do
          questions_left = [double(Question), double(Question), double(Question), double(Question)]
          expect(completion.percentage(questions_left: questions_left)).to eq 0
        end
      end

      context 'they are 0 questions left' do
        it 'should return 100' do
          questions_left = []
          expect(completion.percentage(questions_left: questions_left)).to eq 100
        end
      end

      context 'they are 5 questions left' do
        it 'should thow an error' do
          questions_left = [double(Question), double(Question), double(Question), double(Question), double(Question)]
          expect { completion.percentage(questions_left: questions_left) }.to raise_error
        end
      end
    end
  end
end
