class AddIconToMediaTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :media_types, :icon, :string
  end
end
