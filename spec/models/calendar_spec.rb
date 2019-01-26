require 'rails_helper'

RSpec.describe Calendar, type: :model do
  let!(:user) { create(:user) }
  let!(:calendar) { user.calendars.first }

  it 'creates' do
    expect(calendar).to be_present
  end

  it 'fails to create with no user id' do
    expect {
      create(:calendar, user_id: nil)
    }.to raise_error(
      ActiveRecord::RecordInvalid
    )
  end

  it 'fails to create with no title' do
    expect {
      create(:calendar, title: '')
    }.to raise_error(
      ActiveRecord::RecordInvalid
    )
  end

  it 'gets a months calendar' do
    date = DateTime.now
    arr = (0..2).to_a

    arr.each do |n|
      create(:event,
        start_time: date + n.hours,
        end_time: date + (n + 1).hours,
        calendar_id: calendar.id,
        user_id: user.id
      )
    end

    expect(calendar.get_month_events(date).length).to eq(arr.length)
  end

  it 'belongs to a user' do
    expect(calendar.user.id).to eq(user.id)
  end

  it 'chains many events' do
    events = (0..3).map { |event|
      create(:event, user_id: user.id, calendar_id: calendar.id)
    }
    calendar_events = calendar.events
    ids = calendar_events.pluck(:id)

    calendar_events.each { |evt| expect(evt.calendar_id).to eq(calendar.id) }
    events.each { |evt| expect(ids.include?(evt.id)).to be_truthy }
  end
end
