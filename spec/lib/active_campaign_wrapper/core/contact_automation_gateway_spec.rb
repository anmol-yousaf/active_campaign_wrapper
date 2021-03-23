# frozen_string_literal: true

RSpec.describe ActiveCampaignWrapper::Core::ContactAutomationGateway, :vcr do
  let(:contact_automation_gateway) do
    described_class.new(ActiveCampaignWrapper::Client.new)
  end

  describe '#all', :with_existing_contact do
    subject(:response) { contact_automation_gateway.all(contact_id) }

    it 'returns contact automation hash' do
      expect(response).to include_json(contact_automations: [])
    end
  end
end
