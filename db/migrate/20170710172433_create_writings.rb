class CreateWritings < ActiveRecord::Migration[5.1]
  def change
    create_table :writings do |t|
      t.string :text
      t.references :language, foreign_key: true

      t.timestamps
    end
  end
end
