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
  has_many :supports
  belongs_to :support, optional: true

  #=== SCOPE ===

  scope :active, -> { where(deleted_at: nil, archive_at: nil) }
  scope :deleted, -> { where('deleted_at IS NOT NULL') }
  scope :archived, -> { where('archive_at IS NOT NULL') }
  scope :not_a_topic, -> { where(support_id: nil) }
  scope :topic, -> { where.not(support_id: nil) }

  def reviewable?(translations: Translations::FetchAll.process(self))
    translations.present?
  end

  def last_revision
    reviews.last
  end

  def languages_updatable?(translations: Translations::FetchAll.process(self))
    translations.empty?
  end

  def topic?
    support_id.present?
  end
end
