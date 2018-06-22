class Teacher
  def self.appreciation(answer)
    if answer.correct_with_synonym?
      "That's right! #{answer.question.about.text} means also #{answer.question.expected_answer.text}"
    elsif answer.correct?
      "Excellent!"
    else
      wrong_answer(answer)
    end
  end

  private_class_method

  def self.wrong_answer(answer)
    synonyms = Writings::SynonymsFinder.find_synonyms_of(answer.question.expected_answer).map(&:text).join(',')
    if synonyms.size.zero?
      "Ooops! The right answer is #{answer.question.expected_answer.text}"
    else
      "Ooops! The right answers are #{answer.question.expected_answer.text}, #{synonyms}"
    end
  end
end
