class AddForeignKeysConstraintsToSupport < ActiveRecord::Migration[5.1]
  def change
      Support.connection.execute("ALTER TABLE `supports` CHANGE `media_type_id` `media_type_id` BIGINT(20) NOT NULL;")
      Support.connection.execute("ALTER TABLE supports ADD CONSTRAINT support_media_type_id_fk FOREIGN KEY (media_type_id) REFERENCES media_types (id)")
      Support.connection.execute("ALTER TABLE supports ADD CONSTRAINT support_sourceLanguage_id_fk FOREIGN KEY (sourceLanguage_id) REFERENCES languages (code) ON UPDATE CASCADE")
      Support.connection.execute("ALTER TABLE supports ADD CONSTRAINT support_targetLanguage_id_fk FOREIGN KEY (targetLanguage_id) REFERENCES languages (code) ON UPDATE CASCADE")
  end
end
