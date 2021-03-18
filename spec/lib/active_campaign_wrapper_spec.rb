# frozen_string_literal: true

RSpec.describe ActiveCampaignWrapper do
  it 'has a version number' do
    expect(ActiveCampaignWrapper::API_VERSION).not_to be nil
  end

  describe 'parameters' do
    let(:fake_class) { class_double('ActiveCampaignWrapper') }

    it 'is possible to set api_token' do
      allow(fake_class).to receive(:api_token=).with('123.abc')
      fake_class.api_token = '123.abc'
    end

    it 'is possible to set endpoint_url' do
      allow(fake_class).to receive(:endpoint_url=).with('https://dummy.api-us1.com')
      fake_class.endpoint_url = 'https://dummy.api-us1.com'
    end
  end
end
