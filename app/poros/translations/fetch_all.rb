class Translations::FetchAll
  def self.process(support)
    support.all_translations_not_deleted
  end
end