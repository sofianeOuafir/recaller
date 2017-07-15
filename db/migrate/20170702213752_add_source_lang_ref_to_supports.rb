class AddSourceLangRefToSupports < ActiveRecord::Migration[5.1]
  def change
    add_reference :supports, :sourceLanguage, references: :languages, index: true
    add_foreign_key :supports, :languages, column: :sourceLanguage_id
  end
end
