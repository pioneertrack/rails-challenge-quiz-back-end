FactoryBot.define do
  factory :calendar do
    sequence(:title) { |n| "calendar - #{n}" }
  end
end
