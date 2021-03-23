# frozen_string_literal: true

RSpec.describe ActiveCampaignWrapper::Core::EmailActivityGateway, :vcr do
  let(:email_activity_gateway) do
    described_class.new(ActiveCampaignWrapper::Client.new)
  end

  describe '#all' do
    subject(:response) { email_activity_gateway.all }

    it 'returns email activities hash' do
      expect(response).to include_json(email_activities: [])
    end
  end
end
