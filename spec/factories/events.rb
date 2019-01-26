FactoryBot.define do
  factory :event do
    sequence(:title) { |n| "event title - #{n}" }
    note 'some notes the user entered'
    start_time DateTime.now + 1.months
    end_time DateTime.now + 1.months + 1.hours
  end
end
