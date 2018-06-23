FactoryBot.define do
  factory :support do
    initialize_with { Support.find_or_create_by(name: name) }
    association :sourceLanguage, :french, factory: :language
    association :targetLanguage, :english, factory: :language
    media_type
    user
    support nil
    name 'a support'
  end
end
