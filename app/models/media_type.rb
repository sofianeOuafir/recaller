class MediaType < ApplicationRecord
    before_validation {self.name.strip!}
    before_save { self.name.capitalize! }
    validates :name, presence: true, length: {minimum:2, maximum: 50}
    has_many :supports
end
