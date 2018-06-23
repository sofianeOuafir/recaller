FactoryBot.define do
  factory :translation do
    association :sourceWriting, factory: :writing
    association :targetWriting, factory: :writing
    support
    context 'something'
  end
end
