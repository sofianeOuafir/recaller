class AddArchiveatToSupports < ActiveRecord::Migration[5.1]
  def change
    add_column :supports, :archive_at, :datetime
  end
end
