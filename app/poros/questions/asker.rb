class Questions::Asker
  def initialize(review:, fetcher: Questions::FetcherForReview, picker: Questions::Picker)
    @fetcher = fetcher
    @picker = picker
    @review = review
  end

  def process
    questions = @fetcher.process(@review)
    @picker.process(questions)
  end
end