# frozen_string_literal: true

RSpec.describe ActiveCampaignWrapper::Core::ContactGateway, :vcr do
  let(:contact_gateway) do
    described_class.new(ActiveCampaignWrapper::Client.new)
  end

  describe '#all', :with_existing_contact do
    subject(:response) { contact_gateway.all }

    it 'returns a contacts hash' do
      expect(response).to include_json(contacts: [expected_contact_response])
    end
  end

  describe '#create', :with_contact_params do
    subject(:response) { contact_gateway.create(contact_params) }

    after do
      contact_gateway.delete(response.dig(:contact, :id))
    end

    it 'returns a contact hash' do
      expect(response).to include_json(contact: expected_contact_response)
    end
  end

  describe '#delete', :with_contact_params do
    subject(:response) { contact_gateway.delete(created_contact_id) }

    let!(:created_contact_id) do
      response = contact_gateway.create(contact_params)
      response.dig(:contact, :id)
    end

    it 'returns an empty hash' do
      expect(response).to eq({})
    end
  end

  describe '#update', :with_existing_contact do
    subject(:response) { contact_gateway.update(contact_id, update_params) }

    let(:new_contact_name) { 'Contact name - updated' }
    let(:update_params) do
      {
        first_name: new_contact_name
      }
    end

    let(:expected_contact_update_response) do
      update_params
    end

    it 'returns a contact hash' do
      expect(response).to include_json(contact: expected_contact_update_response)
    end
  end

  describe '#find', :with_existing_contact do
    subject(:response) { contact_gateway.find(contact_id) }

    it 'returns a contact hash' do
      expect(response).to include_json(contact: expected_contact_response)
    end
  end

  describe '#sync', :with_contact_params do
    subject(:response) { contact_gateway.sync(contact_params) }

    after do
      contact_gateway.delete(response.dig(:contact, :id))
    end

    it 'returns a contact hash' do
      expect(response).to include_json(contact: expected_contact_response)
    end
  end

  describe '#update_list_status', :with_existing_list, :with_contact_params do
    subject(:response) { contact_gateway.update_list_status(contact_list_params) }

    after do
      contact_gateway.delete(new_contact_id)
    end

    let!(:new_contact_id) do
      response = contact_gateway.create(contact_params)
      response.dig(:contact, :id)
    end

    let(:contact_list_params) do
      {
        list: list_id,
        contact: new_contact_id,
        status: 1
      }
    end

    it 'returns a contacts list hash' do
      expect(response).to include_json(contacts: [{ id: new_contact_id.to_s }])
    end
  end

  describe '#bulk_import' do
    subject(:response) { contact_gateway.bulk_import(contact_bulk_import_params) }

    let(:contact_bulk_import_params) do
      {
        contacts: [
          {
            email: 'someone@somewhere.com',
            first_name: 'Jane',
            last_name: 'Doe',
            phone: '123-456-7890',
            customer_acct_name: 'ActiveCampaign',
            tags: [
              'dictumst aliquam augue quam sollicitudin rutrum'
            ]
          }
        ]
      }
    end

    it 'returns a success hash' do
      expect(response).to include_json(success: 1)
    end
  end
end
