# frozen_string_literal: true

RSpec.describe ActiveCampaignWrapper::Configuration do
  describe '.new' do
    it 'can be used to intialize a configuration object that can make requests' do
      stub = WebMock.stub_request(:get, 'http://fake.com/').to_return(body: '{}')

      described_class.new.get('http://fake.com/')

      expect(stub).to have_been_requested
    end
  end
end
