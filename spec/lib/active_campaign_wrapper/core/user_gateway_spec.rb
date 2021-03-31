# frozen_string_literal: true

RSpec.describe ActiveCampaignWrapper::Core::UserGateway, :vcr do
  let(:user_gateway) do
    described_class.new(ActiveCampaignWrapper::Client.new)
  end

  describe '#all', :with_existing_user do
    subject(:response) { user_gateway.all }

    it 'returns a user list hash' do
      expect(response).to include_json(users: [{}, expected_user_response])
    end
  end

  describe '#create', :with_user_params do
    subject(:response) { user_gateway.create(user_params) }

    after do
      user_gateway.delete(response.dig(:user, :id))
    end

    it 'returns a user hash' do
      expect(response).to include_json(user: expected_user_response)
    end
  end

  describe '#delete', :with_user_params do
    subject(:response) { user_gateway.delete(created_user_id) }

    let!(:created_user_id) do
      response = user_gateway.create(user_params)
      response.dig(:user, :id)
    end

    it 'returns an empty hash' do
      expect(response).to eq({})
    end
  end

  describe '#update', :with_existing_user do
    subject(:response) { user_gateway.update(user_id, update_params) }

    let(:new_first_name) { 'Anmol' }
    let(:new_last_name)  { 'Yousaf' }
    let(:update_params) do
      {
        first_name: new_first_name,
        last_name: new_last_name,
        group: group_id
      }
    end
    let(:expected_user_update_response) do
      update_params.except(:password, :group)
    end

    it 'returns a user hash' do
      expect(response).to include_json(user: expected_user_update_response)
    end
  end

  describe '#find', :with_existing_user do
    subject(:response) { user_gateway.find(user_id) }

    it 'returns a user hash' do
      expect(response).to include_json(user: expected_user_response)
    end
  end

  describe '#find_by_email', :with_existing_user do
    subject(:response) { user_gateway.find_by_email(user_email) }

    it 'returns a user hash' do
      expect(response).to include_json(user: expected_user_response)
    end
  end

  describe '#find_by_username', :with_existing_user do
    subject(:response) { user_gateway.find_by_username(user_username) }

    it 'returns a user hash' do
      expect(response).to include_json(user: expected_user_response)
    end
  end

  describe '#logged_in', :with_existing_user do
    subject(:response) { user_gateway.logged_in }

    let(:logged_in_user_response) do
      {
        username: 'admin'
      }
    end

    it 'returns a user hash' do
      expect(response).to include_json(user: logged_in_user_response)
    end
  end
end
