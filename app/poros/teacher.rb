class Teacher
  def self.am_i_right?(answer)
    if answer.correct_with_synonym?
      "C'est juste, #{answer.question.about.text} signifie aussi #{answer.question.expected_answer.text}"
    elsif answer.correct?
      "Excellent!"
    else
      wrong_answer(answer)
    end
  end

  private_class_method

  def self.wrong_answer(answer)
    synonyms = Writing::SynonymsFinder.find_synonyms_of(answer.question.expected_answer).map(&:text).join(',')
    if synonyms.size.zero?
      "Oups! La bonne reponse est #{answer.question.expected_answer.text}"
    else
      "Oups! Les bonnes reponses possibles sont #{answer.question.expected_answer.text}, #{synonyms}"
    end
  end
end
