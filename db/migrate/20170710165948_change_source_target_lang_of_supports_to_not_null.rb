class ChangeSourceTargetLangOfSupportsToNotNull < ActiveRecord::Migration[5.1]
  def change
    change_column_null :supports, :sourceLanguage_id, false
  end
end
