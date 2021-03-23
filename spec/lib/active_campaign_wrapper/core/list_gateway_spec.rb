# frozen_string_literal: true

RSpec.describe ActiveCampaignWrapper::Core::ListGateway, :vcr do
  let(:list_gateway) do
    described_class.new(ActiveCampaignWrapper::Client.new)
  end

  describe '#all', :with_existing_list do
    subject(:response) { list_gateway.all }

    it 'returns a list hash' do
      expect(response).to include_json(lists: [expected_list_response])
    end
  end

  describe '#create', :with_list_params do
    subject(:response) { list_gateway.create(list_params) }

    after do
      list_gateway.delete(response.dig(:list, :id))
    end

    it 'returns a list hash' do
      expect(response).to include_json(list: expected_list_response)
    end
  end

  describe '#delete', :with_list_params do
    subject(:response) { list_gateway.delete(created_list_id) }

    let!(:created_list_id) do
      response = list_gateway.create(list_params)
      response.dig(:list, :id)
    end

    it 'returns an empty hash' do
      expect(response).to eq({})
    end
  end

  describe '#update', :with_existing_list do
    subject(:response) { list_gateway.update(list_id, update_params) }

    let(:new_list_name) { 'list name - updated' }
    let(:update_params) do
      {
        name: new_list_name
      }
    end

    it 'returns an empty hash' do
      expect(response).to eq({})
    end
  end

  describe '#find', :with_existing_list do
    subject(:response) { list_gateway.find(list_id) }

    it 'returns a list hash' do
      expect(response).to include_json(list: expected_list_response)
    end
  end
end
