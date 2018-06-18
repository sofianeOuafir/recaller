module Writings
  class Creator
    def self.process(args)
      word = Writing.new(args)
      Writing.find_or_create_by(
        text: word.text,
        language_id: word.language_id
      )
    end
  end
end
