class AddTargetLangRefToSupports < ActiveRecord::Migration[5.1]
  def change
    add_reference :supports, :languageTarget, foreign_key: {to_table: :languages}
  end
end
