class Translations::Creator
  def self.create(params)
    translation = Translation.new(params)
    return translation unless translation.save
    recalculate_support_mark(translation.support)
    translation
  end

  private_class_method

  def self.recalculate_support_mark(support)
    support.update(mark: support.mark - ((1.0/support.translations.count) * support.mark))
  end
end
