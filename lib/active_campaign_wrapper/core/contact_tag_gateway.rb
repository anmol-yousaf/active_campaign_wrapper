# frozen_string_literal: true

module ActiveCampaignWrapper
  module Core
    class ContactTagGateway
      def initialize(client)
        @client = client
        @config = client.config
      end

      def all(contact_id, **params)
        @config.get("/contacts/#{contact_id}/contactTags", query: params)
      end

      def create(params)
        params = { contact_tag: params }
        @config.post('/contactTags', body: params)
      end

      def delete(contact_tag_id)
        @config.delete("/contactTags/#{contact_tag_id}")
      end

      def find(contact_tag_id)
        @config.get("/contactTags/#{contact_tag_id}")
      end
    end
  end
end
