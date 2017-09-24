class Support < ApplicationRecord
    before_validation {self.name.strip!}
    before_save {self.name.capitalize!}

    #================================== VALIDATIONS =========================================
    validates :name, presence: true, length: {minimum: 2, maximum: 255}

    #================================== ASSOCIATIONS ========================================
    belongs_to :sourceLanguage, class_name: "Language"
    belongs_to :targetLanguage, class_name: "Language"
    belongs_to :media_type
    belongs_to :user
    has_many :translations

    #================================== SCOPE ===============================================

	scope :active, -> {where(deleted_at: nil, archive_at:nil)} 
	scope :owner, ->(id) {where('user_id = ?', id)}
	scope :archived, -> {where('archive_at IS NOT NULL')}




end
