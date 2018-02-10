class RemoveTextFromAnswers < ActiveRecord::Migration[5.1]
  def change
    remove_column :answers, :text, :string
  end
end
