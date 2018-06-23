FactoryBot.define do
  factory :question do
    review
    translation
    writing

    trait :correctly_answered do
      correctly_answered true
    end
  end
end
