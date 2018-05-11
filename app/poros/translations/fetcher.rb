class Translations::Fetcher
  attr_reader :review

  def self.process(review)
    new(review).process
  end

  def initialize(review)
    @review = review
  end

  def process
    review.not_deleted_translations
  end
end
