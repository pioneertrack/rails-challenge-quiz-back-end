require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  let!(:email) { 'some@email.com' }
  let!(:pass) { 'testtest' }
  let!(:user) { create(:user, email: email, password: pass, password_confirmation: pass) }

  it 'authenticates the user' do
    post :login, params: { email: email, password: pass }

    body = JSON.parse(response.body)

    expect(response).to be_successful
    expect(body['access_token']).to be_present
  end

  it 'fails to authenticate a user with bad credentials' do
    post :login, params: { email: 'another@email.com', password: pass }

    expect(response).not_to be_successful
  end

  it 'fails to authenticate a user with bad credentials' do
    post :login, params: { email: email, password: 'different' }

    expect(response).not_to be_successful
    expect(response.status).to eq(401)
  end
end
