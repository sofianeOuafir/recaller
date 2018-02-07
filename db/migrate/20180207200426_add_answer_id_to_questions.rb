class AddAnswerIdToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_reference :questions, :writing, foreign_key: true
  end
end
