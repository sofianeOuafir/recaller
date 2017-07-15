class AddForeignKeyLanguageToWritings < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :writings, :languages
  end
end
