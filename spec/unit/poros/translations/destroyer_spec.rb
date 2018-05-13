require 'rails_helper'

RSpec.describe Translations::Destroyer, type: :unit do
  let(:translation) { instance_double(Translation) }
  describe '#process' do
    context 'the user want to delete a translation from a list' do
      context 'the translation is not deleted' do
        before do
          allow(translation).to receive(:deleted_at)
        end
        it 'should update deleted_at with the current datetime' do
          expect(translation).to receive(:update).with(hash_including(:deleted_at))
          Translations::Destroyer.process(translation)
        end
      end

      context 'the translation has already been deleted' do
        before do
          allow(translation).to receive(:deleted_at) { DateTime.now }
        end
        it 'should not update deleted_at with the current datetime' do
          expect(translation).not_to receive(:update)
          Translations::Destroyer.process(translation)
        end
      end
    end
  end
end