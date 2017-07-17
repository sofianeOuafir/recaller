class AddUserReferencesToSupports < ActiveRecord::Migration[5.1]
  def change
    add_reference :supports, :user, foreign_key: true, index: true
  end
end
