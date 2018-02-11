class AddReverseToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :reverse, :boolean
  end
end
