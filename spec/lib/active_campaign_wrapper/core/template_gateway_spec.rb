# frozen_string_literal: true

RSpec.describe ActiveCampaignWrapper::Core::TemplateGateway, :vcr do
  let(:template_gateway) do
    described_class.new(ActiveCampaignWrapper::Client.new)
  end

  describe '#all' do
    subject(:response) { template_gateway.all }

    it 'returns a template list hash' do
      expect(response).to include_json(templates: [])
    end
  end

  describe '#find' do
    # It is not possible to create a template via API.
    # Update template id for the test to pass
    subject(:response) { template_gateway.find(100001) }

    it 'returns a template hash' do
      expect(response).to include_json(template: {})
    end
  end

  describe '#delete' do
    # It is not possible to create a template via API.
    # Update template id for the test to pass
    subject(:response) { template_gateway.delete(100001) }

    it 'returns an empty hash' do
      expect(response).to eq({})
    end
  end
end
