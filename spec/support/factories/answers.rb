FactoryBot.define do
  factory :answer do
    question
    review
    writing
    
    trait :correct do
      correct true
    end
  end
end
