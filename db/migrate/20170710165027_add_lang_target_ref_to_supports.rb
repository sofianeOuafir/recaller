class AddLangTargetRefToSupports < ActiveRecord::Migration[5.1]
  def change
    add_reference :supports, :targetLanguage, foreign_key: {to_table: :languages}
  end
end
