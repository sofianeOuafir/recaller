class Translations::FetchMistaken
  def self.process(revision)
    return if revision.nil?
    questions = Question.where(id: ids_of_questions_answered_incorrectly(revision))
    Translation.where(id: questions.map(&:translation_id))
  end

  private 

  def self.ids_of_questions_answered_incorrectly(revision)
    # TODO Create Revisions::IncorrectAnswersFetcher
    revision.answers.incorrect.map(&:question_id)
  end
end
