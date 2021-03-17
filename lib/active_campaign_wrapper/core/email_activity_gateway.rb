# frozen_string_literal: true

module ActiveCampaignWrapper
  module Core
    class EmailActivityGateway
      def initialize(client)
        @client = client
        @config = client.config
      end

      def all(**params)
        @config.get('/emailActivities', query: params)
      end
    end
  end
end
