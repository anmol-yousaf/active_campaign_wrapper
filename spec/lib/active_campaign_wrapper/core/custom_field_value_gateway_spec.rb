# frozen_string_literal: true

RSpec.describe ActiveCampaignWrapper::Core::CustomFieldValueGateway, :vcr do
  let(:custom_field_value_gateway) do
    described_class.new(ActiveCampaignWrapper::Client.new)
  end

  describe '#create', :with_text_field_value_params do
    subject(:response) { custom_field_value_gateway.create(field_value_params) }

    after do
      custom_field_value_gateway.delete(response.dig(:field_value, :id))
    end

    it 'returns a field_value hash' do
      expect(response).to include_json(field_value: expected_field_value_response)
    end
  end

  describe '#find', :with_existing_text_field_value do
    subject(:response) { custom_field_value_gateway.find(field_value_id) }

    it 'returns a field_value hash' do
      expect(response).to include_json(field_value: expected_field_value_response)
    end
  end

  describe '#all', :with_existing_text_field_value do
    it 'returns a field_value hash' do
      response = custom_field_value_gateway.all
      expect(response).to include_json(field_values: [expected_field_value_response])
    end

    it 'includes field values when field id filter matches' do
      response = custom_field_value_gateway.all(filters: { fieldid: field_id })
      expect(response).to include_json(field_values: [expected_field_value_response])
    end

    it 'excludes field values when field id filter does not match' do
      response = custom_field_value_gateway.all(filters: { fieldid: field_id.to_i + 1 })
      expect(response).not_to include_json(field_values: [expected_field_value_response])
    end

    it 'includes field values when value filter matches' do
      response = custom_field_value_gateway.all(filters: { val: field_value[:value] })
      expect(response).to include_json(field_values: [expected_field_value_response])
    end

    it 'excludes field values when value filter does not match' do
      response = custom_field_value_gateway.all(filters: { val: 'non-existing' })
      expect(response).not_to include_json(field_values: [expected_field_value_response])
    end
  end

  describe '#update', :with_existing_text_field_value do
    subject(:response) { custom_field_value_gateway.update(field_value_id, update_params) }

    let(:new_value) { 'Updated' }
    let(:update_params) do
      {
        contact: contact_id,
        field: field_id,
        value: new_value
      }
    end

    let(:expected_update_response) do
      update_params
    end

    it 'returns a field_value hash' do
      expect(response).to include_json(field_value: expected_update_response)
    end
  end

  describe '#delete', :with_text_field_value_params do
    subject(:response) { custom_field_value_gateway.delete(created_custom_field_value_id) }

    let!(:created_custom_field_value_id) do
      response = custom_field_value_gateway.create(field_value_params)
      response.dig(:field_value, :id)
    end

    it 'returns an empty hash' do
      expect(response).to eq({})
    end
  end
end
