# frozen_string_literal: true

RSpec.shared_context 'with text field value params', with_text_field_value_params: true do
  include_context 'with existing contact'
  include_context 'with existing text field'

  let!(:contact_id) { contact[:id] }
  let!(:value)      { 'Text field value' }
  let(:field_value_params) do
    {
      contact: contact_id,
      field: field_id,
      value: value
    }
  end

  let(:expected_field_value_response) do
    field_value_params
  end
end

RSpec.shared_context 'with existing text field value', with_existing_text_field_value: true do
  include_context 'with text field value params'

  let!(:client) { ActiveCampaignWrapper::Client.new }
  let!(:field_value) do
    response = client.custom_field_values.create(field_value_params)
    response.fetch(:field_value) { raise "HELL (custom field value creation failed) #{response}" }
  end
  let(:field_value_id) { field_value[:id] }

  after do
    client.custom_field_values.delete(field_value_id) if field_value_id
  end
end
