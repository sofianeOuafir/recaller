class AddReviewToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_reference :answers, :review, foreign_key: true
  end
end
