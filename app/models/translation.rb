class Translation < ApplicationRecord
  before_validation {self.context.strip!}
  before_save {self.context.capitalize!}
  validates :context, length: {maximum:500}
  belongs_to :support
  belongs_to :sourceWriting, class_name: "Writing"
  belongs_to :targetWriting, class_name: "Writing"
end
