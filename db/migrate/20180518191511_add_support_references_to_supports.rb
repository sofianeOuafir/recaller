class AddSupportReferencesToSupports < ActiveRecord::Migration[5.1]
  def change
    add_reference :supports, :support, foreign_key: true, optional: true
  end
end
