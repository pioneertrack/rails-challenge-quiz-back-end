require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:email) { 'some@email.com' }
  let!(:pass) { 'testtest' }
  let!(:user) { create(:user, email: email, password: pass, password_confirmation: pass) }
  let!(:headers) { { token: user.access_token('Rails Testing') } }
  let!(:bad_headers) { { token: user.access_token('bad-agent') } }

  it 'creates new user' do
    diff_email = 'another.user@email.com'

    post :create, params: { user: {
      name: 'some name',
      email: diff_email,
      password: pass,
      password_confirmation: pass
    }}

    body = JSON.parse(response.body)

    expect(response).to be_successful
    expect(body['user']['email']).to eq(diff_email)
    expect(body['access_token']).to be_present
  end

  it 'fails to create a new user with one word for a name' do
    diff_email = 'another.user@email.com'

    post :create, params: { user: {
      name: 'first',
      email: diff_email,
      password: pass,
      password_confirmation: pass
    }}

    body = JSON.parse(response.body)

    expect(response).not_to be_successful
    expect(body['message']).to be_present
    expect(response.status).to eq(422)
  end

  it 'gets the current user' do
    request.headers.merge!(headers)

    get :show

    body = JSON.parse(response.body)

    expect(response).to be_successful
    expect(body['user']['email']).to eq(email)
  end

  it 'fails to get current user with bad token' do
    request.headers.merge!(bad_headers)

    get :show

    body = JSON.parse(response.body)

    expect(response).not_to be_successful
    expect(body['message']).to be_present
    expect(response.status).to eq(401)
  end

  it 'fails to get current user with no token' do
    get :show

    body = JSON.parse(response.body)

    expect(response).not_to be_successful
    expect(body['message']).to be_present
    expect(response.status).to eq(401)
  end

  it 'updates the current user' do
    name = 'another name'
    email = 'some@other.com'

    request.headers.merge!(headers)

    post :update, params: { user: {
      name: name,
      email: email
    }}

    body = JSON.parse(response.body)

    expect(response).to be_successful
    expect(body['user']['email']).to eq(email)
    expect(body['user']['name']).to eq(name)
  end

  it 'fails to update the current user with invalid token' do
    request.headers.merge!(bad_headers)

    post :update, params: { user: {
      name: 'another name',
      email: 'some@other.com'
    }}

    body = JSON.parse(response.body)

    expect(response).not_to be_successful
    expect(body['message']).to be_present
    expect(response.status).to eq(401)
  end

  it 'fails to update the current user with invalid email' do
    request.headers.merge!(headers)

    post :update, params: { user: { email: 'not@.email' } }

    body = JSON.parse(response.body)

    expect(response).not_to be_successful
    expect(body['message']).to be_present
    expect(response.status).to eq(422)
  end

  it 'fails to update the current user with invalid name' do
    request.headers.merge!(headers)

    post :update, params: { user: { name: '' } }

    body = JSON.parse(response.body)

    expect(response).not_to be_successful
    expect(body['message']).to be_present
    expect(response.status).to eq(422)
  end
end
