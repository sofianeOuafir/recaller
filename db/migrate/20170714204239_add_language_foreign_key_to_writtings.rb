class AddLanguageForeignKeyToWrittings < ActiveRecord::Migration[5.1]
  def change
    remove_column :writings, :language_id, :string
    add_column :writings, :language_id, :string
    add_index :writings, :language_id
    Writing.connection.execute("ALTER TABLE writings ADD CONSTRAINT writing_language_id_fk FOREIGN KEY (language_id) REFERENCES languages (code) ON UPDATE CASCADE")
  end
end
