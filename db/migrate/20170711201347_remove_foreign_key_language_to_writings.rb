class RemoveForeignKeyLanguageToWritings < ActiveRecord::Migration[5.1]
  def change
      remove_foreign_key :writings, :languages
  end
end
