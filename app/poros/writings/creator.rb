module Writings
  class Creator
    attr_reader :text, :language_id, :model
    def initialize(text:, language_id:, model: Writing)
      @text = text
      @language_id = language_id
      @model = model
    end

    def process
      model.find_or_create_by(
        text: text,
        language_id: language_id
      )
    end
  end
end
