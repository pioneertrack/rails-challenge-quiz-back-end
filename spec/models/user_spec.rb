require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:pass) { 'testtest' }
  let!(:user) { create(:user, password: pass, password_confirmation: pass) }
  let!(:calendar) { user.calendars.first }

  it 'creates' do
    expect(User.first.id).to eq(user.id)
  end

  it 'downcases email before validations' do
    email = 'anOTHER@emaIL.com'

    user.update_attributes(email: email)

    expect(user.email).to eq(email.downcase)
  end

  it 'fails to create with invalid emails' do
    emails = ['some@m.c', 'a@.com', 'some@1.x', nil]

    emails.each do |email|
      expect {
        create(:user, email: email)
      }.to raise_error(
        ActiveRecord::RecordInvalid
      )
    end
  end

  it 'fails to create when name is not present' do
    expect {
      create(:user, name: '')
    }.to raise_error(
      ActiveRecord::RecordInvalid
    )
  end

  it 'fails to create when full name is not present' do
    expect {
      create(:user, name: 'first')
    }.to raise_error(
      ActiveRecord::RecordInvalid
    )
  end

  it 'authenticates' do
    expect(
      User.authenticate(user.email, pass).id
    ).to eq(
      user.id
    )
  end

  it 'fails to authenticate with invalid password' do
    expect(User.authenticate(user.email, 'another')).to be_nil
  end

  it 'fails to authenticate with email password' do
    expect(User.authenticate('some@other.com', pass)).to be_nil
  end

  it 'creates on after create user' do
    expect(user.calendars.first).to be_present
    expect(user.calendars.first.title).to eq(user.name)
  end

  it 'chains many calendars' do
    calendars = (0..3).map { |calendar|
      create(:calendar, user_id: user.id)
    }
    user_calendars = user.calendars
    ids = user_calendars.pluck(:id)

    user_calendars.each { |c| expect(c.user_id).to eq(user.id) }
    calendars.each { |c| expect(ids.include?(c.id)).to be_truthy }
  end

  it 'chains many events' do
    events = (0..3).map { |event|
      create(:event, user_id: user.id, calendar_id: calendar.id)
    }
    user_events = user.events
    ids = user_events.pluck(:id)

    user_events.each { |evt| expect(evt.user_id).to eq(user.id) }
    events.each { |evt| expect(ids.include?(evt.id)).to be_truthy }
  end
end
