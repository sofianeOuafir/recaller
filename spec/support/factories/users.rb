FactoryBot.define do
  factory :user do
    initialize_with { User.find_or_create_by(email: email)}
    username 'username'
    password 'password'
    email 'email@email.com'
  end
end
