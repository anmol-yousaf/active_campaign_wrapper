# frozen_string_literal: true

RSpec.shared_context 'with text field params', with_text_field_params: true do
  let(:field_title)            { 'Custom text' }
  let(:field_type)             { 'text' }
  let(:field_description)      { 'A custom text field' }
  let(:field_is_required)      { '0' }
  let(:field_personalized_tag) { 'perstag' }
  let(:field_default_value)    { 'Default value' }
  let(:field_visible)          { '1' }
  let(:field_params) do
    {
      title: field_title,
      type: field_type,
      descript: field_description,
      isrequired: field_is_required,
      perstag: field_personalized_tag.upcase,
      defval: field_default_value,
      visible: field_visible
    }
  end

  let(:expected_field_response) do
    field_params
  end
end

RSpec.shared_context 'with existing text field', with_existing_text_field: true do
  include_context 'with text field params'

  let!(:client) { ActiveCampaignWrapper::Client.new }
  let!(:field) do
    response = client.custom_fields.create(field_params)
    response.fetch(:field) { raise "HELL (custom text field creation failed) #{response}" }
  end
  let(:field_id) do
    field[:id]
  end

  after do
    client.custom_fields.delete(field_id) if field_id
  end
end
