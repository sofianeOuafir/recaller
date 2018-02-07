class Question < ApplicationRecord
  belongs_to :review
  belongs_to :translation
  belongs_to :writing
end
