class Reviews::Creator
  def self.process(support:,
                  what_to_study: 'all',
                  question_creator: Questions::Creator,
                  translations_fetcher: Translations::Fetcher,
                  translations: translations_fetcher.process(support: support, what_to_study: what_to_study),
                  review: Review.new(support_id: support.id))
    return unless translations.present?
    review.save
    create_questions(review: review,
                     translations: translations,
                     question_creator: question_creator)
    set_support_mark_to_zero(support)
    review
  end

  private_class_method

  def self.create_questions(review:, translations:, question_creator:)
    translations.each do |translation|
      question_creator.process(translation: translation, review: review)
    end
  end

  def self.set_support_mark_to_zero(support)
    support.update(mark: 0)
  end
end
