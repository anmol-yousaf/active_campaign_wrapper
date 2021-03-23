# frozen_string_literal: true

RSpec.describe ActiveCampaignWrapper::Core::ContactTagGateway, :vcr do
  let(:contact_tag_gateway) do
    described_class.new(ActiveCampaignWrapper::Client.new)
  end

  describe '#all', :with_existing_contact_tag do
    subject(:response) { contact_tag_gateway.all(contact_id) }

    it 'returns a contact tags hash' do
      expect(response).to include_json(contact_tags: [expected_contact_tag_response])
    end
  end

  describe '#create', :with_contact_tag_params do
    subject(:response) { contact_tag_gateway.create(contact_tag_params) }

    after do
      contact_tag_gateway.delete(response.dig(:contact_tag, :id))
    end

    it 'returns a contact tag hash' do
      expect(response).to include_json(contact_tag: expected_contact_tag_response)
    end
  end

  describe '#delete', :with_contact_tag_params do
    subject(:response) { contact_tag_gateway.delete(created_contact_tag_id) }

    let!(:created_contact_tag_id) do
      response = contact_tag_gateway.create(contact_tag_params)
      response.dig(:contact_tag, :id)
    end

    it 'returns an empty hash' do
      expect(response).to eq({})
    end
  end

  describe '#find', :with_existing_contact_tag do
    subject(:response) { contact_tag_gateway.find(contact_tag_id) }

    it 'returns a contact tag hash' do
      expect(response).to include_json(contact_tag: expected_contact_tag_response)
    end
  end
end
