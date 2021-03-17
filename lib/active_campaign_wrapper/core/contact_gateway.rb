# frozen_string_literal: true

module ActiveCampaignWrapper
  module Core
    class ContactGateway
      def initialize(client)
        @client = client
        @config = client.config
      end

      def all(**params)
        @config.get('/contacts', query: params)
      end

      def create(params)
        params = { contact: params }
        @config.post('/contacts', body: params)
      end

      def sync(params)
        params = { contact: params }
        @config.post('/contact/sync', body: params)
      end

      def update_list_status(params)
        params = { contact_list: params }
        @config.post('/contactLists', body: params)
      end

      def bulk_import(params)
        @config.post('/import/bulk_import', body: params)
      end

      def delete(contact_id)
        @config.delete("/contacts/#{contact_id}")
      end

      def update(contact_id, params)
        params = { contact: params }
        @config.put("/contacts/#{contact_id}", body: params)
      end

      def find(contact_id)
        @config.get("/contacts/#{contact_id}")
      end
    end
  end
end
