require 'rails_helper'

RSpec.describe ApplicationController, type: :request do
  it 'handles a not found route gracefully' do
    get '/'

    body = JSON.parse(response.body)

    expect(response).not_to be_successful
    expect(body['message']).to be_present
    expect(response.status).to eq(404)
  end
end
