class AddDeletedAtToSupport < ActiveRecord::Migration[5.1]
  def change
    add_column :supports, :deleted_at, :datetime
  end
end
