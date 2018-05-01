class Translations::Destroyer
  def self.process(translation)
    return if translation.deleted_at.present?
    translation.update(deleted_at: DateTime.now)
  end
end