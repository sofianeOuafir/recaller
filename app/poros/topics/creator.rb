class Topics::Creator
  attr_reader :params, :translations, :duplicator
  # TODO need to belong to support_id, should be compulsory for a topic
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
    return topic unless topic.save
    return topic unless translations.present?
    duplicator.process(translations: translations, listable: topic)
    topic
  end
end