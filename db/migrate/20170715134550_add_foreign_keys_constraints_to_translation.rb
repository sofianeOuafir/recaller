class AddForeignKeysConstraintsToTranslation < ActiveRecord::Migration[5.1]
  def change

    Translation.connection.execute("ALTER TABLE `translations` CHANGE `targetWriting_id` `targetWriting_id` BIGINT(20) NOT NULL;")
    Translation.connection.execute("ALTER TABLE `translations` CHANGE `sourceWriting_id` `sourceWriting_id` BIGINT(20) NOT NULL;")
    Translation.connection.execute("ALTER TABLE `translations` CHANGE `support_id` `support_id` BIGINT(20) NOT NULL;")
    Translation.connection.execute("ALTER TABLE translations ADD CONSTRAINT translation_support_id_fk FOREIGN KEY (support_id) REFERENCES supports (id)")
    Translation.connection.execute("ALTER TABLE translations ADD CONSTRAINT translation_sourceWriting_id_fk FOREIGN KEY (sourceWriting_id) REFERENCES writings (id)")
    Translation.connection.execute("ALTER TABLE translations ADD CONSTRAINT translation_targetWriting_id_fk FOREIGN KEY (targetWriting_id) REFERENCES writings (id)")

  end
end
