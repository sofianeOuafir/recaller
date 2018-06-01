class Questions::Generator
  attr_reader :translation, :reverse, :answer
  def initialize(translation, reverse: rand(0..1).zero?)
    @translation = translation
    @reverse = reverse
    @answer = reverse ? @translation.sourceWriting : @translation.targetWriting
  end

  def process
    if reverse
      "What is the meaning of '#{translation.targetWriting.text}' in #{answer.language.name} ?"
    else
      "What is the meaning of '#{translation.sourceWriting.text}' in #{answer.language.name} ?"
    end
  end
end
