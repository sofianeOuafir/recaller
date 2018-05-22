class Topics::Creator
  attr_reader :params, :translations, :duplicator
  def initialize(params:, translations: nil, duplicator: Translations::Duplicator)
    @params = params
    @translations = translations
    @duplicator = duplicator
  end

  def self.process(params:, translations: nil, duplicator: Translations::Duplicator)
    new(params: params, translations: translations, duplicator: duplicator).process
  end

  def process
    topic = Support.new(params)
    raise 'A topic must belong to a list in order to be created' unless topic.support_id.present?
    return topic unless topic.save
    return topic unless translations.present?
    duplicator.process(translations: translations, listable: topic)
    topic
  end
end