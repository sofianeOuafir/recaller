class ChangeColumnTextOfWritings < ActiveRecord::Migration[5.1]
  def change
    change_column_null :writings, :language_id, false
    change_column_null :writings, :text, false
  end
end
