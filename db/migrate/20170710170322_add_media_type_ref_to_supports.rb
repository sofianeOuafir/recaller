class AddMediaTypeRefToSupports < ActiveRecord::Migration[5.1]
  def change
    add_reference :supports, :media_type, foreign_key: true
  end
end
