FactoryBot.define do
  factory :media_type do
    initialize_with { MediaType.find_or_create_by(name: name) }
    name 'something'
    trait :book do
      name 'Book'
    end
  end
end
