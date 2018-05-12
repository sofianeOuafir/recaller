require 'rails_helper' 

RSpec.describe Translations::Fetcher do
  let(:support) { instance_double(Support, last_revision: nil) }
  let(:fetcher_of_all_translations) { spy(Translations::FetchAll) }
  let(:fetcher_of_mistaken_translations) { spy(Translations::FetchMistaken) }
  let(:fetcher) do
    Translations::Fetcher.new(
      fetcher_of_all_translations: fetcher_of_all_translations,
      fetcher_of_mistaken_translations: fetcher_of_mistaken_translations,
      support: support
    )
  end

  describe '#process' do
    context 'The Fetcher is asked to fetch all translations' do
      before do
        @action = :fetch_all
      end

      it 'should fetch all not deleted translations for the given support' do
        fetcher.process(action: @action)
        expect(fetcher_of_all_translations).to have_received(:process)
      end

      it 'should not fetch mistaken translations for the given support' do
        fetcher.process(action: @action)
        expect(fetcher_of_mistaken_translations).not_to have_received(:process)
      end
    end

    context 'The Fetcher is asked to fetch mistaken translations (from last review)' do
      before do
        @action = :fetch_mistaken
      end

      it 'should not fetch all translations for the given support' do
        fetcher.process(action: @action)
        expect(fetcher_of_all_translations).not_to have_received(:process)
      end

      it 'should fetch mistaken translations for the last review' do
        fetcher.process(action: @action)
        expect(fetcher_of_mistaken_translations).to have_received(:process)
      end
    end

    context 'The fetcher is asked to process without any action' do
      it 'should fetch all translations' do
        fetcher.process
        expect(fetcher_of_all_translations).to have_received(:process)
      end
    end
  end
end
