class ChangeSourceLangOfSupportsToString < ActiveRecord::Migration[5.1]
  def change
    change_column :supports, :sourceLanguage_id, :string
  end
end
