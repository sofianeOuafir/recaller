class Questions::Picker
  def self.process(questions)
    random_number = rand(0..questions.size - 1)
    questions[random_number]
  end
end
