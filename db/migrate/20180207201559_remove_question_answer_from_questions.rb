class RemoveQuestionAnswerFromQuestions < ActiveRecord::Migration[5.1]
  def change
    remove_column :questions, :question_answer_id
  end
end
