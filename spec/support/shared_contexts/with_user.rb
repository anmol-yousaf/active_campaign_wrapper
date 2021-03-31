# frozen_string_literal: true

RSpec.shared_context 'with user params', with_user_params: true do
  include_context 'with existing group'

  let(:user_username)   { 'anmoly' }
  let(:user_email)      { 'anmoly@gmail.com' }
  let(:user_first_name) { 'Anmol' }
  let(:user_last_name)  { 'Y' }
  let(:user_password)   { 'mypasswordisstrong' }
  let(:user_params) do
    {
      username: user_username,
      email: user_email,
      first_name: user_first_name,
      last_name: user_last_name,
      group: group_id,
      password: user_password
    }
  end

  let(:expected_user_response) do
    user_params.except(:group, :password)
  end
end

RSpec.shared_context 'with existing user', with_existing_user: true do
  include_context 'with user params'

  let!(:client) { ActiveCampaignWrapper::Client.new }
  let!(:user) do
    response = client.users.create(user_params)
    response.fetch(:user) { raise "HELL (user creation failed) #{response}" }
  end
  let(:user_id) { user[:id] }

  after do
    client.users.delete(user_id) if user_id
  end
end
