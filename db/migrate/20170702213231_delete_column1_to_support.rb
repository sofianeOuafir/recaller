class DeleteColumn1ToSupport < ActiveRecord::Migration[5.1]
  def change
    remove_column :supports, :language_id, :integer
  end
end
