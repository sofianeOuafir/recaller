class Teacher
  def self.am_i_right?(answer)
    if answer.correct_with_synonym?
      "C'est juste, #{answer.question.about.text} signifie aussi #{answer.question.writing.text}"
    elsif answer.correct?
      "Excellent!"
    else
      "Oups! La bonne reponse est #{answer.question.writing.text}"
    end
  end
end
