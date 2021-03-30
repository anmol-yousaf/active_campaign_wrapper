# frozen_string_literal: true

RSpec.describe ActiveCampaignWrapper::Core::GroupGateway, :vcr do
  let(:group_gateway) do
    described_class.new(ActiveCampaignWrapper::Client.new)
  end

  describe '#all', :with_existing_group do
    subject(:response) { group_gateway.all }

    it 'returns a group hash' do
      expect(response).to include_json(groups: [expected_group_response])
    end
  end

  describe '#create', :with_group_params do
    subject(:response) { group_gateway.create(group_params) }

    after do
      group_gateway.delete(response.dig(:group, :id))
    end

    it 'returns a group hash' do
      expect(response).to include_json(group: expected_group_response)
    end
  end

  describe '#delete', :with_group_params do
    subject(:response) { group_gateway.delete(created_group_id) }

    let!(:created_group_id) do
      response = group_gateway.create(group_params)
      response.dig(:group, :id)
    end

    it 'returns an empty hash' do
      expect(response).to eq({})
    end
  end

  describe '#update', :with_existing_group do
    subject(:response) { group_gateway.update(group_id, update_params) }

    let(:new_group_title) { 'group title - updated' }
    let(:update_params) do
      {
        title: new_group_title
      }
    end

    it 'returns a group hash' do
      expect(response).to include_json(group: update_params)
    end
  end

  describe '#find', :with_existing_group do
    subject(:response) { group_gateway.find(group_id) }

    it 'returns a group hash' do
      expect(response).to include_json(group: expected_group_response)
    end
  end
end
