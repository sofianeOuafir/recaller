class Questions::Generator
  attr_reader :translation, :reverse, :answer
  def initialize(translation, reverse: rand(0..1).zero?)
    @translation = translation
    @reverse = reverse
    @answer = reverse ? @translation.sourceWriting : @translation.targetWriting
  end

  def process
    if reverse
      generate_question_from(translation.targetWriting)
    else
      generate_question_from(translation.sourceWriting)
    end
  end

  private

  def generate_question_from(writing)
    formats = [
      "What is the meaning of \"#{writing.text}\" in #{answer.language.name}",
      "What is the #{answer.language.name} for \"#{writing.text}\"",
      "If I tell you \"#{writing.text}\", what do you understand?",
      "In #{answer.language.name}, how do we say \"#{writing.text}\"?",
      "Do you know how to say \"#{writing.text}\" in #{answer.language.name}?",
      "Write down the definition of \"#{writing.text}\" in #{answer.language.name}?",
      "Do you recall what \"#{writing.text}\" means in #{answer.language.name}?"
    ]

    formats[rand(0..formats.length - 1)]
  end
end
