class Writing::SynonymsFinder
  def self.find_synonyms_of(writing)
    has_defined_ids = writing.has_defined.map(&:id)
    definitions_ids = writing.definitions.map(&:id)
    synonym_ids = Translation.all.not_deleted.where(sourceWriting_id: has_defined_ids).map(&:targetWriting_id)
    synonym_ids << Translation.all.not_deleted.where(targetWriting_id: definitions_ids).map(&:sourceWriting_id)
    synonym_ids.flatten
    Writing.where(id: synonym_ids).where.not(id: writing.id)
  end
end
