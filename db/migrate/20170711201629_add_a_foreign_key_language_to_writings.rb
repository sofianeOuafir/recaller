class AddAForeignKeyLanguageToWritings < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :writings, :languages, column: :language_id, primary_key: :code
  end
end
