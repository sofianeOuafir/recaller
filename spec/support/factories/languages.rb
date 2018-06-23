FactoryBot.define do
  factory :language do
    initialize_with { Language.find_or_create_by(code: code, name: name)}
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
