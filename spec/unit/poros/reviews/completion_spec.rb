require 'rails_helper'

RSpec.describe Reviews::Completion, type: :unit do
  describe '#percentage' do
    context 'the revision is nil' do
      it 'should throw an error'
    end

    context 'the revision has no questions' do
      it 'should return nil'
    end

    context 'the revision has 4 questions' do
      context 'they are 1 question left' do
        it 'should return 75'
      end

      context 'they are 4 questions left' do
        it 'should return 0'
      end

      context 'they are 0 questions left' do
        it 'should return 100'
      end

      context 'they are 5 questions left' do
        it 'should thow an error'
      end
    end
  end
end
