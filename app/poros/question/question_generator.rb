class Question::QuestionGenerator
  attr_reader :translation

  def initialize(args)
    @translation = args[:translation]
  end

  def generate
    "Quel est la definition du mot #{translation.sourceWriting.text} en #{translation.targetWriting.language.name} ?"
  end
end
