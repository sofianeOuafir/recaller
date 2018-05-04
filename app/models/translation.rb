class Translation < ApplicationRecord
  before_validation { context.strip! }
  before_save { context.capitalize! }

  belongs_to :support
  belongs_to :sourceWriting, class_name: "Writing"
  belongs_to :targetWriting, class_name: "Writing"

  scope :not_deleted, -> { where(deleted_at: nil) }
end
