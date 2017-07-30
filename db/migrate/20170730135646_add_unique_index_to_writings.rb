class AddUniqueIndexToWritings < ActiveRecord::Migration[5.1]
  def change
    add_index :writings, [:text, :language_id], unique: true
  end
end
