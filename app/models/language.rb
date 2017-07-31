class Language < ApplicationRecord
    #TODO language name need to be capitalized before save
    before_validation {self.name.strip!; self.code.strip!}
    validates :name, presence: true, length: {minimum:2, maximum:50}
    validates :code, presence: true, length: {is: 2}
    has_many :writings
    has_many :supportsAsSource, :class_name => "Support", :foreign_key => :sourceLanguage
    has_many :supportsAsTarget, :class_name => "Support", :foreign_key => :targetLanguage
end
