FactoryBot.define do
  factory :writing do
    initialize_with { Writing.find_or_create_by(text: text, language: language) }
    text 'Bonjour'
    association :language, :french
  end
end
