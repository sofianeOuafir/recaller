class Question < ApplicationRecord

  belongs_to :review
  belongs_to :translation
end
