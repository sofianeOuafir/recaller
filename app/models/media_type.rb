class MediaType < ApplicationRecord
  before_validation { name.strip! }
  before_save { name.capitalize! }

  ICONS = {
    'Course' => 'ion-university',
    'Book' => 'ion-ios-book-outline',
    'Movie' => 'ion-ios-videocam',
    'Music' => 'ion-music-note'

  }

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }

  has_many :supports
end
