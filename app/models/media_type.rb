class MediaType < ApplicationRecord
    #TODO mediaType name need to be capitalized before save
    before_validation {self.name.strip!}
    before_save { self.name.downcase! }
    validates :name, presence: true, length: {minimum:2, maximum: 50}
    has_many :supports
end
