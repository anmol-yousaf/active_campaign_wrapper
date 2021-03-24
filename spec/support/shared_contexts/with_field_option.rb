# frozen_string_literal: true

RSpec.shared_context 'with field option params', with_field_option_params: true do
  let(:option_1_title)   { 'Option 1' }
  let(:option_1_value)   { 'Option 1' }
  let(:option_2_title)   { 'Option 2' }
  let(:option_2_value)   { 'Option 2' }
  # Note that a field id of '0' is invalid, and either the hash must be overwritten, or let(:field_id) overwritten, further
  #   down the chain, before a call is made using this parameter hash
  let(:options_field_id) { '0' }
  let(:field_option_params) do
    [
      {
        field: options_field_id,
        label: option_1_title,
        value: option_1_value
      },
      {
        field: options_field_id,
        label: option_2_title,
        value: option_2_value
      }
    ]
  end

  let(:expected_field_option_response) do
    field_option_params
  end
end

RSpec.shared_context 'with radio field params', with_radio_field_params: true do
  let(:field_title)            { 'Custom radio' }
  let(:field_type)             { 'radio' }
  let(:field_description)      { 'A custom radio field' }
  let(:field_is_required)      { '0' }
  let(:field_personalized_tag) { 'Personalized Tag' }
  let(:field_default_value)    { 'Default value' }
  let(:field_visible)          { '1' }
  let(:radio_field_params) do
    {
      title: field_title,
      type: field_type,
      descript: field_description,
      isrequired: field_is_required,
      perstag: field_personalized_tag,
      visible: field_visible
    }
  end

  let(:expected_field_response) do
    field_params
  end
end

RSpec.shared_context 'with existing radio field', with_existing_radio_field: true do
  include_context 'with radio field params'

  let!(:client) { ActiveCampaignWrapper::Client.new }
  let!(:field) do
    response = client.custom_fields.create(radio_field_params)
    response.fetch(:field) { raise "HELL (custom radio field creation failed) #{response}" }
  end

  let(:field_id) { field[:id] }

  after do
    client.custom_fields.delete(field_id) if field_id
  end
end

RSpec.shared_context 'with existing radio field with options', with_existing_radio_field_with_options: true do
  include_context 'with existing radio field'
  include_context 'with field option params'

  let(:options_field_id) { field_id } # This overrides the options field id in 'with field option params'

  let!(:field_options) do
    response = client.custom_field_options.create(field_option_params)
    response.fetch(:field_options) { raise "HELL (custom field options creation failed) #{response}" }
  end

  let(:field_option_ids) do
    field_options.map do |option|
      option[:id]
    end
  end
end
