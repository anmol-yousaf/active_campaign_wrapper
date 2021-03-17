# frozen_string_literal: true

module ActiveCampaignWrapper
  module Core
    class ContactScoreValueGateway
      def initialize(client)
        @client = client
        @config = client.config
      end

      def all(contact_id, **params)
        @config.get("/contacts/#{contact_id}/scoreValues", query: params)
      end
    end
  end
end
