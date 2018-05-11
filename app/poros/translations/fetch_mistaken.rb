class Translations::FetchMistaken
  def self.process(support)
    support.translations_mistaken_in_last_revision
  end
end