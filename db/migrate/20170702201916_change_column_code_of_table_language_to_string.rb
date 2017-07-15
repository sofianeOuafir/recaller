class ChangeColumnCodeOfTableLanguageToString < ActiveRecord::Migration[5.1]
  def change
    change_column :languages, :code, :string
        add_column :writings, :language_id, :string
        add_foreign_key :writings, :languages, column: :language_id, primary_key: :code, on_update: :cascade
        add_index :writings, :language_id
  end
end
