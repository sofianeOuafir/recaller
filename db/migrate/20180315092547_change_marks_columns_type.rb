class ChangeMarksColumnsType < ActiveRecord::Migration[5.1]
  def change
    change_column :reviews, :mark, :float
    change_column :supports, :mark, :float
  end
end
