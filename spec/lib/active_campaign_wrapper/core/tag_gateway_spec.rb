# frozen_string_literal: true

RSpec.describe ActiveCampaignWrapper::Core::TagGateway, :vcr do
  let(:tag_gateway) do
    described_class.new(ActiveCampaignWrapper::Client.new)
  end

  describe '#all', :with_existing_tag do
    subject(:response) { tag_gateway.all }

    it 'returns a tag list hash' do
      expect(response).to include_json(tags: [expected_tag_response])
    end
  end

  describe '#create', :with_tag_params do
    subject(:response) { tag_gateway.create(tag_params) }

    after do
      tag_gateway.delete(response.dig(:tag, :id))
    end

    it 'returns a tag hash' do
      expect(response).to include_json(tag: expected_tag_response)
    end
  end

  describe '#delete', :with_tag_params do
    subject(:response) { tag_gateway.delete(created_tag_id) }

    let!(:created_tag_id) do
      response = tag_gateway.create(tag_params)
      response.dig(:tag, :id)
    end

    it 'returns an empty hash' do
      expect(response).to eq({})
    end
  end

  describe '#update', :with_existing_tag do
    subject(:response) { tag_gateway.update(tag_id, update_params) }

    let(:new_tag_name)        { 'Tag name - updated' }
    let(:new_tag_type)        { 'template' }
    let(:new_tag_description) { 'Tag description - updated' }
    let(:update_params) do
      {
        tag: new_tag_name,
        tag_type: new_tag_type,
        description: new_tag_description
      }
    end

    let(:expected_tag_update_response) do
      update_params
    end

    it 'returns a tag hash' do
      expect(response).to include_json(tag: expected_tag_update_response)
    end
  end

  describe '#find', :with_existing_tag do
    subject(:response) { tag_gateway.find(tag_id) }

    it 'returns a tag hash' do
      expect(response).to include_json(tag: expected_tag_response)
    end
  end
end
