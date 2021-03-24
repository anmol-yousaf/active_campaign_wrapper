# frozen_string_literal: true

RSpec.describe ActiveCampaignWrapper::Core::CustomFieldOptionGateway, :vcr do
  let(:custom_field_option_gateway) do
    described_class.new(ActiveCampaignWrapper::Client.new)
  end

  describe '#create', :with_existing_radio_field, :with_field_option_params do
    subject(:response) { custom_field_option_gateway.create(field_option_params) }

    let(:options_field_id) { field_id } # Override the default field id in 'with field option params' context

    it 'returns a field option hash' do
      expect(response).to include_json(field_options: expected_field_option_response)
    end
  end

  describe '#find', :with_existing_radio_field_with_options do
    subject(:response) { custom_field_option_gateway.find(field_option_ids.first) }

    it 'returns a field option hash' do
      expect(response).to include_json(field_option: expected_field_option_response.first)
    end
  end

  describe '#delete', :with_existing_radio_field_with_options do
    subject(:response) { custom_field_option_gateway.delete(field_option_ids.first) }

    it 'returns nothing' do
      expect(response).to be_empty
    end
  end
end
