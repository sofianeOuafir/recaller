FactoryBot.define do
  factory :language do
    trait :french do
      name 'french'
      code 'fr'
    end

    trait :english do
      name 'english'
      code 'gb'
    end
  end
end
