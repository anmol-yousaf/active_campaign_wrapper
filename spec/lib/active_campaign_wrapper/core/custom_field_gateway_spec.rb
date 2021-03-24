# frozen_string_literal: true

RSpec.describe ActiveCampaignWrapper::Core::CustomFieldGateway, :vcr do
  let(:custom_field_gateway) do
    described_class.new(ActiveCampaignWrapper::Client.new)
  end

  describe '#create', :with_text_field_params do
    subject(:response) { custom_field_gateway.create(field_params) }

    after do
      custom_field_gateway.delete(response.dig(:field, :id))
    end

    it 'returns a field hash' do
      expect(response).to include_json(field: expected_field_response)
    end
  end

  describe '#find', :with_existing_text_field do
    subject(:response) { custom_field_gateway.find(field_id) }

    it 'returns a field hash' do
      expect(response).to include_json(field: expected_field_response)
    end
  end

  describe '#all', :with_existing_text_field do
    subject(:response) { custom_field_gateway.all }

    it 'returns a fields hash' do
      expect(response).to include_json(fields: [expected_field_response])
    end
  end

  describe '#update', :with_existing_text_field do
    subject(:response) { custom_field_gateway.update(field_id, update_params) }

    let(:new_field_title)            { 'Custom text - updated' }
    let(:new_field_type)             { 'text' }
    let(:new_field_description)      { 'A custom text field - updated' }
    let(:new_field_is_required)      { '1' }
    let(:new_field_personalized_tag) { 'perstag' }
    let(:new_field_default_value)    { 'Default value - updated' }
    let(:new_field_visible)          { '1' }
    let(:update_params) do
      {
        title: new_field_title,
        type: new_field_type,
        descript: new_field_description,
        isrequired: new_field_is_required,
        defval: new_field_default_value,
        visible: new_field_visible
      }
    end

    let(:expected_field_update_response) do
      update_params
    end

    it 'returns a field hash' do
      expect(response).to include_json(field: expected_field_update_response)
    end
  end

  describe '#delete', :with_text_field_params do
    subject(:response) { custom_field_gateway.delete(created_custom_field_id) }

    let!(:created_custom_field_id) do
      response = custom_field_gateway.create(field_params)
      response.dig(:field, :id)
    end

    it 'returns an empty hash' do
      expect(response).to eq({})
    end
  end
end
