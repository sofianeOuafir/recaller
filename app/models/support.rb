class Support < ApplicationRecord
    belongs_to :sourceLanguage, class_name: "Language"
    belongs_to :targetLanguage, class_name: "Language"
    belongs_to :media_type
    has_many :translations
end
