# frozen_string_literal: true

RSpec.describe ActiveCampaignWrapper::Core::ListGroupGateway, :vcr do
  let(:list_group_gateway) do
    described_class.new(ActiveCampaignWrapper::Client.new)
  end

  describe '#all', :with_existing_list_group do
    subject(:response) { list_group_gateway.all }

    it 'returns a list groups hash' do
      expect(response).to include_json(list_groups: [expected_list_group_response])
    end
  end

  describe '#create', :with_list_group_params do
    subject(:response) { list_group_gateway.create(list_group_params) }

    after do
      list_group_gateway.delete(response.dig(:list_group, :id))
    end

    it 'returns a list group hash' do
      expect(response).to include_json(list_group: expected_list_group_response)
    end
  end

  describe '#delete', :with_list_group_params do
    subject(:response) { list_group_gateway.delete(created_list_group_id) }

    let!(:created_list_group_id) do
      response = list_group_gateway.create(list_group_params)
      response.dig(:list_group, :id)
    end

    it 'returns an empty hash' do
      expect(response).to eq({})
    end
  end

  describe '#find', :with_existing_list_group do
    subject(:response) { list_group_gateway.find(list_group_id) }

    it 'returns a list group hash' do
      expect(response).to include_json(list_group: expected_list_group_response)
    end
  end
end
