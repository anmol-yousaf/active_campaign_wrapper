# frozen_string_literal: true

module ActiveCampaignWrapper
  module Core
    class CustomFieldOptionGateway
      def initialize(client)
        @client = client
        @config = client.config
      end

      def create(params)
        params = { field_options: params }
        @config.post('/fieldOption/bulk', body: params)
      end
    end
  end
end
