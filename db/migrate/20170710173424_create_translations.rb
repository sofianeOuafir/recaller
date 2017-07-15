class CreateTranslations < ActiveRecord::Migration[5.1]
  def change
    create_table :translations do |t|
      t.text :context
      t.references :support, foreign_key: true

      t.timestamps
    end
    add_reference :translations, :targetWriting, foreign_key: {to_table: :writings}
    add_reference :translations, :sourceWriting, foreign_key: {to_table: :writings}
  end
end
