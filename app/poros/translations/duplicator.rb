class Translations::Duplicator
  attr_reader :translations, :listable, :translations_creator

  def initialize(translations:, listable:, translations_creator: Translations::Creator)
    @translations = translations
    @listable = listable
    @translations_creator = translations_creator
  end

  def self.process(translations:, listable:, translations_creator: Translations::Creator)
    new(translations: translations, listable: listable, translations_creator: translations_creator).process
  end

  def process
    translations.each do |translation|
      new_translation = Translation.new(
        context: translation.context,
        support_id: listable.id,
        targetWriting_id: translation.targetWriting_id,
        sourceWriting_id: translation.sourceWriting_id
      )
      translations_creator.create(new_translation)
    end
  end
end