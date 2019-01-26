FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    name 'john doe'
    password 'testtest'
    password_confirmation 'testtest'
  end
end
