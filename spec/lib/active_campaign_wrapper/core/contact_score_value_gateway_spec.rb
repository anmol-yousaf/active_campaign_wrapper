# frozen_string_literal: true

RSpec.describe ActiveCampaignWrapper::Core::ContactScoreValueGateway, :vcr do
  let(:contact_score_value_gateway) do
    described_class.new(ActiveCampaignWrapper::Client.new)
  end

  describe '#all', :with_existing_contact do
    subject(:response) { contact_score_value_gateway.all(contact_id) }

    it 'returns contact score values hash' do
      expect(response).to include_json(score_values: [])
    end
  end
end
