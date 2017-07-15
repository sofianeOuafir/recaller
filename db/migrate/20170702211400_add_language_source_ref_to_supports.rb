class AddLanguageSourceRefToSupports < ActiveRecord::Migration[5.1]
  def change
    add_reference :supports, :language, foreign_key: true
  end
end
