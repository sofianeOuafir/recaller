class Translations::FetchMistaken
  def self.process(revision)
    return if revision.nil?
    questions = Question.where(id: ids_of_questions_answered_incorrectly(revision))
    Translation.where(id: questions.map(&:translation_id))
  end

  private 

  def self.ids_of_questions_answered_incorrectly(revision)
    Reviews::IncorrectAnswerFetcher.process(revision).map(&:question_id)
  end
end
