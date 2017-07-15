class RemoveTargetLangRefToSupports < ActiveRecord::Migration[5.1]
  def change
    remove_reference :supports, :languageTarget, foreign_key: {to_table: :languages}
  end
end
