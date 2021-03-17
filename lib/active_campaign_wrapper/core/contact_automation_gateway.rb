# frozen_string_literal: true

module ActiveCampaignWrapper
  module Core
    class ContactAutomationGateway
      def initialize(client)
        @client = client
        @config = client.config
      end

      def all(contact_id, **params)
        @config.get("/contacts/#{contact_id}/contactAutomations", query: params)
      end
    end
  end
end
