require 'rails_helper' 

RSpec.describe Translations::FetchAll do
  let!(:translation) { create_translation }
  let(:support) { translation.support }

  describe '#process' do
    context 'the translation is not deleted' do
      it 'should return 1 translation' do
        number_of_translation = Translations::FetchAll.process(support)
        expect(number_of_translation.count).to eq 1
      end
    end

    context 'the translation has been deleted' do
      before do
        translation.update_columns(deleted_at: Time.now)
      end

      it 'should return 0 translation' do
        number_of_translation = Translations::FetchAll.process(support)
        expect(number_of_translation.count).to be_zero
      end
    end
  end
end