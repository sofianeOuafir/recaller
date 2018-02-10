class Writing::SynonymsFinder
  def self.find(writing)
    has_defined_ids = writing.has_defined.map(&:id)
    synonym_ids = Translation.all.where(sourceWriting_id: has_defined_ids).map(&:targetWriting_id)
    Writing.where(id: synonym_ids).where.not(id: writing.id)
  end
end
