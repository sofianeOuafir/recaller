class MigrateMarks < ActiveRecord::Migration[5.1]
  def change
    Review.all.each do |review|
      review.update(mark: Reviews::MarkCalculator.calculate(review))
    end
  end
end
