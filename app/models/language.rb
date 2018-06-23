class Language < ApplicationRecord
  before_validation { name.strip!; code.strip! }
  before_save { name.capitalize! }

  validates :name, presence: true, length: { minimum:2, maximum:50 }
  validates :code, presence: true, length: { is: 2 }

  has_many :writings
  has_many :supports_as_source, :class_name => "Support", :foreign_key => :sourceLanguage
  has_many :supports_as_target, :class_name => "Support", :foreign_key => :targetLanguage
end
