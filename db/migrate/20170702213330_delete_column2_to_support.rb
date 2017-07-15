class DeleteColumn2ToSupport < ActiveRecord::Migration[5.1]
  def change
  remove_column :supports, :sourceLanguage_id, :integer

  end
end
