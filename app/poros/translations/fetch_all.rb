class Translations::FetchAll
  def self.process(support)
    support.translations.not_deleted
  end
end

