class Writing < ApplicationRecord
  before_validation {self.text.strip!}
  before_save {self.text.capitalize!}
  validates :text, length: {minimum:2, maximum: 255}, presence: true, uniqueness: { scope: :language_id}

  belongs_to :language

  has_many :translationsAsSource, :class_name => "Translation", :foreign_key => :sourceWriting_id
  has_many :translationsAsTarget, :class_name => "Translation", :foreign_key => :targetWriting_id
  has_many :definitions, :through => :translationsAsSource, :source => :targetWriting
  has_many :hasDefined, :through => :translationsAsTarget, :source => :sourceWriting

  def to_s
    return self.text
  end
end
