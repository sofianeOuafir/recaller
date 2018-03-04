class AddCompleteToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :complete, :boolean, default: false
  end
end
