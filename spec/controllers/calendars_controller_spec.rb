require 'rails_helper'

RSpec.describe CalendarsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:calendar) { user.calendars.first }
  let!(:headers) { { token: user.access_token('Rails Testing') } }
  let!(:bad_headers) { { token: user.access_token('bad-agent') } }

  it 'creates' do
    title = 'crazy title'
    request.headers.merge!(headers)

    post :create, params: { calendar: { title: title } }

    body = JSON.parse(response.body)

    expect(response).to be_successful
    expect(body['calendar']).to be_present
    expect(body['calendar']['title']).to eq(title)
  end

  it 'shows the current users calendar by id' do
    request.headers.merge!(headers)

    get :show, params: { id: calendar.id }

    body = JSON.parse(response.body)

    expect(response).to be_successful
    expect(body['calendar']).to be_present
    expect(body['calendar']['user_id']).to eq(user.id)
  end

  it 'fails to show the current users calendar by id' do
    request.headers.merge!(bad_headers)

    get :show, params: { id: calendar.id }

    body = JSON.parse(response.body)

    expect(response).not_to be_successful
    expect(body['message']).to be_present
    expect(response.status).to eq(401)
  end

  it 'fails to show the current users calendar by id due to wrong user sending request' do
    other_user = create(:user)
    request.headers.merge!({
      token: other_user.access_token('Rails Testing')
    })

    get :show, params: { id: calendar.id }

    body = JSON.parse(response.body)

    expect(response).not_to be_successful
    expect(body['message']).to be_present
    expect(response.status).to eq(404)
  end

  it 'gets the current users calendars' do
    request.headers.merge!(headers)

    get :show_user_calendars

    body = JSON.parse(response.body)

    expect(response).to be_successful
    expect(body['calendars']).to be_present
    expect(body['calendars'].class).to eq(Array)
  end

  it 'gets a months calendar' do
    request.headers.merge!(headers)
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

    get :month_events, params: {
      id: calendar.id,
      date: date
    }

    body = JSON.parse(response.body)

    expect(response).to be_successful
    expect(body['events'].length).to eq(arr.length)
  end

  it 'fail to get a months calendar due to invalid date' do
    request.headers.merge!(headers)
    date = DateTime.now

    (0..2).each do |n|
      create(:event,
        start_time: date + n.hours,
        end_time: date + (n + 1).hours,
        calendar_id: calendar.id,
        user_id: user.id
      )
    end

    get :month_events, params: {
      id: calendar.id,
      date: 'some invalid date'
    }

    body = JSON.parse(response.body)

    expect(response).not_to be_successful
    expect(body['message']).to be_present
  end
end
