class ChangeColumnLanguageOfWriting < ActiveRecord::Migration[5.1]
  def change
    change_column :writings, :language_id, :string
  end
end
