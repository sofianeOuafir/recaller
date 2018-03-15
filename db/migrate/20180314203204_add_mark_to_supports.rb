class AddMarkToSupports < ActiveRecord::Migration[5.1]
  def change
    add_column :supports, :mark, :integer, default: 0
  end
end
