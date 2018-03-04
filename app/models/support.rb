class Support < ApplicationRecord

  before_validation { name.strip! }
  before_save { name.capitalize! }

  # === VALIDATIONS ===

  validates :name, presence: true, length: { minimum: 2, maximum: 255 }

  #=== ASSOCIATIONS ===

  belongs_to :sourceLanguage, class_name: 'Language'
  belongs_to :targetLanguage, class_name: 'Language'
  belongs_to :media_type
  belongs_to :user
  has_many :translations
  has_many :reviews

  #=== SCOPE ===

  scope :active, -> { where(deleted_at: nil, archive_at: nil) }
  scope :deleted, -> { where('deleted_at IS NOT NULL') }
  scope :archived, -> { where('archive_at IS NOT NULL') }

  def reviewable?
    translations.present?
  end

  def mark
    last_review.mark
  end

  def last_review
    reviews.last
  end
end
