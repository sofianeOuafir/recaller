class Translations::Fetcher
  attr_reader :review, :fetcher_of_all_translations, :fetcher_of_mistaken_translations

  def self.process(review:, fetcher_of_all_translations: Translations::FetchAll, fetcher_of_mistaken_translations: Translations::FetchMistaken)
    new(review: review, fetcher_of_all_translations: fetcher_of_all_translations, fetcher_of_mistaken_translations: fetcher_of_mistaken_translations).process
  end

  def initialize(review:, fetcher_of_all_translations: Translations::FetchAll, fetcher_of_mistaken_translations: Translations::FetchMistaken)
    @review = review
    @fetcher_of_all_translations = fetcher_of_all_translations
    @fetcher_of_mistaken_translations = fetcher_of_mistaken_translations
  end

  def process(action: nil)
    if fetch_all?(action)
      fetcher_of_all_translations.process(review.support)
    elsif fetch_mistaken?(action)
      fetcher_of_mistaken_translations.process(review)
    elsif no_action?(action)
      fetcher_of_all_translations.process(review.support)
    end
  end

  private 

  def fetch_all?(action)
    action == :fetch_all
  end

  def fetch_mistaken?(action)
    action == :fetch_mistaken
  end

  def no_action?(action)
    action.nil?
  end
end
