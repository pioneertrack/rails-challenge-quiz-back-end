require 'rails_helper'
require Rails.root.join('lib/util/json_web_token.rb')

RSpec.describe Util::JsonWebToken do
  let!(:user_agent) { 'some-agent' }
  let!(:user) { create(:user) }
  let!(:token) { Util::JsonWebToken.encode(user, user_agent) }

  it 'encodes a user token' do
    expect(token).to be_present
    expect(token.is_a?(String)).to be_truthy
  end

  it 'decodes a member token' do
    decoded = Util::JsonWebToken.decode(token)

    expect(decoded[:user_id]).to be(user.id)
    expect(decoded[:user_agent]).to eq(user_agent)
  end
end
