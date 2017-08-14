class Language < ApplicationRecord
    before_validation {self.name.strip!; self.code.strip!}
    before_save {self.name.capitalize!}
    validates :name, presence: true, length: {minimum:2, maximum:50}
    validates :code, presence: true, length: {is: 2}
    has_many :writings
    has_many :supportsAsSource, :class_name => "Support", :foreign_key => :sourceLanguage
    has_many :supportsAsTarget, :class_name => "Support", :foreign_key => :targetLanguage
end
