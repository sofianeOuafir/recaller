class RemoveIconColumnFromMediaTypes < ActiveRecord::Migration[5.1]
  def change
    remove_column :media_types, :icon, :string
  end
end
