require 'rails_helper'

RSpec.describe Event, type: :model do
  let!(:user) { create(:user) }
  let!(:calendar) { user.calendars.first }
  let!(:event) { create(:event, calendar_id: calendar.id, user_id: user.id) }

  it 'creates' do
    expect(event).to be_present
  end

  it 'fails to create when the user id does not equal the calendars user id' do
    expect {
      create(:event, calendar_id: calendar.id, user_id: 11111111111)
    }.to raise_error(
      ActiveRecord::RecordInvalid
    )
  end

  it 'raises an error if missing required fields' do
    [:title, :start_time, :end_time].each do |field|
      expect {
        event.update_attributes!(field => nil)
      }.to raise_error(
        ActiveRecord::RecordInvalid
      )
    end
  end

  it 'raises an error if end time before start time' do
    time = DateTime.now

    expect {
      event.update_attributes!(start_time: time, end_time: time)
    }.to raise_error(
      ActiveRecord::RecordInvalid
    )
  end

  it 'belongs to a user' do
    expect(event.user.id).to eq(user.id)
  end

  it 'belongs to a calendar' do
    expect(event.calendar.id).to eq(calendar.id)
  end
end
