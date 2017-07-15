class Language < ApplicationRecord
    validates :name, presence: true
    validates :code, length: {is: 2}
    has_many :writings
    has_many :supportsAsSource, :class_name => "Support", :foreign_key => :sourceLanguage
    has_many :supportsAsTarget, :class_name => "Support", :foreign_key => :targetLanguage
end
