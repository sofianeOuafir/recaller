require 'rails_helper' 

RSpec.describe Translations::Fetcher do
  let(:review) { instance_double(Review) }
  let(:fetcher_of_all_translations) { spy(Translations::FetchAll) }
  let(:fetcher_of_mistaken_translations) { spy(Translations::FetchMistaken) }
  let(:fetcher) do
    Translations::Fetcher.new(
      fetcher_of_all_translations: fetcher_of_all_translations,
      fetcher_of_mistaken_translations: fetcher_of_mistaken_translations,
      review: review
    )
  end
  describe '#process' do
    before do
      allow(review).to receive(:not_deleted_translations)
    end
    context 'The Fetcher is asked to fetch all translations' do
      before do
        @action = :fetch_all
      end

      it 'should fetch all not deleted translations for the given review' do
        fetcher.process(action: @action)
        expect(fetcher_of_all_translations).to receive(:process)
      end

      it 'should not fetch mistaken translations for the given review' do
        fetcher.process(action: @action)
        expect(fetcher_of_mistaken_translations).not_to receive(:process)
      end
    end

    context 'The Fetcher is asked to fetch mistaken translations (from previous review)' do
      before do
        @action = :fetch_mistaken
      end

      it 'should not fetch all translations for the given review' do
        fetcher.process(action: @action)
        expect(fetcher_of_all_translations).not_to receive(:process)
      end

      it 'should fetch mistaken translations for the given review' do
        fetcher.process(action: @action)
        expect(fetcher_of_mistaken_translations).to receive(:process)
      end
    end
  end
end
