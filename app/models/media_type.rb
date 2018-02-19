class MediaType < ApplicationRecord
  before_validation { name.strip! }
  before_save { name.capitalize! }

  ICONS = {
    'Cours' => 'ion-university',
    'Livre' => 'ion-ios-book-outline',
    'Film' => 'ion-ios-videocam',
    'Musique' => 'ion-music-note'

  }

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }

  has_many :supports
end
