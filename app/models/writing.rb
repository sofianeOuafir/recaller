class Writing < ApplicationRecord
  before_validation {self.text.strip!}
  before_save {self.text.capitalize!}
  validates :text, length: {minimum:2, maximum: 255}, presence: true, uniqueness: { scope: :language_id}

  belongs_to :language

  #List of translations when the word is used as the source
  has_many :translationsAsSource, :class_name => "Translation", :foreign_key => :sourceWriting_id

  #list of translations when the word is used as the target
  has_many :translationsAsTarget, :class_name => "Translation", :foreign_key => :targetWriting_id

  #list of word that has been a definition for self (source -> target)
  has_many :definitions, :through => :translationsAsSource, :source => :targetWriting

  #list of word that has been defined by self
  has_many :hasDefined, :through => :translationsAsTarget, :source => :sourceWriting

  def to_s
    return self.text
  end

end