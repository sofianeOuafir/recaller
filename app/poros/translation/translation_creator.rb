class Translation::TranslationCreator
  def self.create(translation)
    return translation unless translation.save
    Review::MarkCalculator.calculate(translation.support)
    translation
  end
end
