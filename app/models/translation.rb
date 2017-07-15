class Translation < ApplicationRecord
  belongs_to :support
  belongs_to :sourceWriting, class_name: "Writing"
  belongs_to :targetWriting, class_name: "Writing"
end
