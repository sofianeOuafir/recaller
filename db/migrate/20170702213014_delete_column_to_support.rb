class DeleteColumnToSupport < ActiveRecord::Migration[5.1]
  def change
    remove_column :supports, :language, :integer
  end
end
