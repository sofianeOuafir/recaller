class Add < ActiveRecord::Migration[5.1]
  def change
    remove_column :translations, :deleted_at, :datetime
  end
end
