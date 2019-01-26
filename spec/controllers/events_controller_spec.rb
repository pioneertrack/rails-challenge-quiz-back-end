require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:calendar) { user.calendars.first }
  let!(:headers) { { token: user.access_token('Rails Testing') } }
  let!(:bad_headers) { { token: user.access_token('bad-agent') } }
  let!(:event) { create(:event, calendar_id: calendar.id, user_id: user.id) }

  it 'creates' do
    title = 'some event title'
    note = 'some event note'
    start_time = DateTime.new
    end_time = start_time + 1.hours

    request.headers.merge!(headers)

    post :create, params: {
      calendar_id: calendar.id,
      event: {
        title: title,
        note: note,
        start_time: start_time,
        end_time: end_time
      }
    }

    body = JSON.parse(response.body)

    expect(response).to be_successful
    expect(body['event']).to be_present
    expect(body['event']['title']).to eq(title)
    expect(body['event']['note']).to eq(note)
    expect(
      body['event']['start_time'].to_datetime.to_i
    ).to eq(start_time.to_i)
    expect(
      body['event']['end_time'].to_datetime.to_i
    ).to eq(end_time.to_i)
  end

  it 'fails to create with bad token' do
    start_time = DateTime.new
    end_time = start_time + 1.hours

    request.headers.merge!(bad_headers)

    post :create, params: {
      calendar_id: calendar.id,
      event: {
        title: 'some event title',
        note: 'some event note',
        start_time: start_time,
        end_time: end_time
      }
    }

    body = JSON.parse(response.body)

    expect(response).not_to be_successful
    expect(body['message']).to be_present
    expect(response.status).to eq(401)
  end

  it 'shows' do
    request.headers.merge!(headers)

    get :show, params: {
      id: event.id,
      calendar_id: calendar.id
    }

    body = JSON.parse(response.body)

    expect(response).to be_successful
    expect(body['event']['id']).to eq(event.id)
  end

  it 'updates' do
    new_title = 'new title'
    new_note = 'some new note'
    start_time = DateTime.now + 1.years
    end_time = start_time + 1.hours
    request.headers.merge!(headers)

    put :update, params: {
      id: event.id,
      calendar_id: calendar.id,
      event: {
        title: new_title,
        note: new_note,
        start_time: start_time,
        end_time: end_time
      }
    }

    body = JSON.parse(response.body)

    expect(response).to be_successful
    expect(body['event']['id']).to eq(event.id)
    expect(body['event']['title']).to eq(new_title)
    expect(body['event']['note']).to eq(new_note)
    expect(
      body['event']['start_time'].to_datetime.to_i
    ).to eq(start_time.to_i)
    expect(
      body['event']['end_time'].to_datetime.to_i
    ).to eq(end_time.to_i)
  end

  it 'deletes' do
    request.headers.merge!(headers)

    delete :delete, params: {
      id: event.id,
      calendar_id: calendar.id
    }

    body = JSON.parse(response.body)

    expect(response).to be_successful
    expect(body['message']).to be_present
  end

  it 'fails to delete with invalid calendar id' do
    request.headers.merge!(headers)

    delete :delete, params: {
      id: event.id,
      calendar_id: 1111111111111
    }

    body = JSON.parse(response.body)

    expect(response).not_to be_successful
    expect(body['message']).to be_present
    expect(response.status).to eq(404)
  end
end
