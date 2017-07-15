class CreateLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :languages, id: false do |t|
      t.string :name
      t.string :code, primary: true

      t.timestamps
    end
  end
end
