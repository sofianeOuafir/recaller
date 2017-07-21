class Support < ApplicationRecord
    before_validation {self.name.strip!}
    before_save {self.name.capitalize!}
    validates :name, presence: true, length: {minimum: 2, maximum: 255}
    belongs_to :sourceLanguage, class_name: "Language"
    belongs_to :targetLanguage, class_name: "Language"
    belongs_to :media_type
    belongs_to :user
    has_many :translations
end
