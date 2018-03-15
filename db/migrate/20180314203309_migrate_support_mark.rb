class MigrateSupportMark < ActiveRecord::Migration[5.1]
  def change
    Support.all.each do |support|
      next if support.reviews.empty?
      support.update(mark: support.reviews.last.mark)
    end
  end
end
