class ChangeColumnCodeToLanguage < ActiveRecord::Migration[5.1]
  def change
    change_column :languages, :code, :primary_key
    change_column_null :languages, :code, false
  end
end
