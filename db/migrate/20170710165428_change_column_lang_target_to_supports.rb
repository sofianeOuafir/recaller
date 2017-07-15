class ChangeColumnLangTargetToSupports < ActiveRecord::Migration[5.1]
  def change
    change_column :supports, :targetLanguage_id, :string
    change_column_null :supports, :targetLanguage_id, false
  end
end
