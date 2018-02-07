class RemoveWritingFromAnswers < ActiveRecord::Migration[5.1]
  def change
    remove_reference :answers, :writing, foreign_key: true
  end
end
