class AddForeignKeysConstraintsToSupport < ActiveRecord::Migration[5.1]
  def change
      Translation.connection.execute("ALTER TABLE `supports` CHANGE `media_type_id` `media_type_id` BIGINT(20) NOT NULL;")
      Translation.connection.execute("ALTER TABLE supports ADD CONSTRAINT support_media_type_id_fk FOREIGN KEY (media_type_id) REFERENCES media_types (id)")
      Translation.connection.execute("ALTER TABLE supports ADD CONSTRAINT support_sourceLanguage_id_fk FOREIGN KEY (sourceLanguage_id) REFERENCES languages (code)")
      Translation.connection.execute("ALTER TABLE supports ADD CONSTRAINT support_targetLanguage_id_fk FOREIGN KEY (targetLanguage_id) REFERENCES languages (code)")
  end
end
