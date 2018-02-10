class Writing < ApplicationRecord
  before_validation { text.strip! }
  before_save { text.capitalize! }
  validates :text, length: { minimum:2, maximum: 255 }, presence: true, uniqueness: { scope: :language_id }

  belongs_to :language
  has_many :questions

  has_many :translations_as_source, :class_name => "Translation", :foreign_key => :sourceWriting_id
  has_many :translations_as_target, :class_name => "Translation", :foreign_key => :targetWriting_id
  has_many :definitions, :through => :translations_as_source, :source => :targetWriting
  has_many :has_defined, :through => :translations_as_target, :source => :sourceWriting

  def synonyms
    Writing::SynonymsFinder.find(self)
  end

  def to_s
    text
  end
end
