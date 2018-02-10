class AddWritingReferencesToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_reference :answers, :writing, foreign_key: true
  end
end
