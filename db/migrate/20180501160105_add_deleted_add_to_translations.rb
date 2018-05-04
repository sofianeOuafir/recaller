class AddDeletedAddToTranslations < ActiveRecord::Migration[5.1]
  def change
    add_column :translations, :deleted_at, :datetime
  end
end
