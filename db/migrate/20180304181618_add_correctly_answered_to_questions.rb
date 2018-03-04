class AddCorrectlyAnsweredToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :correctly_answered, :boolean, default: false
  end
end
