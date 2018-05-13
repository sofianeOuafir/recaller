class Translations::Fetcher
  attr_reader :support, :fetcher_of_all_translations, :fetcher_of_mistaken_translations

  def self.process(support:,
                   what_to_study: nil,
                   fetcher_of_all_translations: Translations::FetchAll,
                   fetcher_of_mistaken_translations: Translations::FetchMistaken)
    new(support: support,
        fetcher_of_all_translations: fetcher_of_all_translations, 
        fetcher_of_mistaken_translations: fetcher_of_mistaken_translations)
      .process(what_to_study: what_to_study)
  end

  def initialize(support:,
                 fetcher_of_all_translations: Translations::FetchAll,
                 fetcher_of_mistaken_translations: Translations::FetchMistaken)
    @support = support
    @fetcher_of_all_translations = fetcher_of_all_translations
    @fetcher_of_mistaken_translations = fetcher_of_mistaken_translations
  end

  def process(what_to_study: nil)
    if study_all?(what_to_study)
      translations = fetcher_of_all_translations.process(support)
    elsif study_mistaken?(what_to_study)

      translations = fetcher_of_mistaken_translations.process(support.last_revision)
    elsif no_argument?(what_to_study)
      translations = fetcher_of_all_translations.process(support)
    end
    translations
  end

  private

  def study_all?(what_to_study)
    what_to_study == "all"
  end

  def study_mistaken?(what_to_study)
    what_to_study == "mistaken"
  end

  def no_argument?(what_to_study)
    what_to_study.nil?
  end
end
