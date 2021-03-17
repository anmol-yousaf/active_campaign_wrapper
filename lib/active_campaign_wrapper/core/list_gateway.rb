# frozen_string_literal: true

module ActiveCampaignWrapper
  module Core
    class ListGateway
      def initialize(client)
        @client = client
        @config = client.config
      end

      def all(**params)
        @config.get('/lists', query: params)
      end

      def create(params)
        params = { list: params }
        @config.post('/lists', body: params)
      end

      def delete(list_id)
        @config.delete("/lists/#{list_id}")
      end

      def update(list_id, params)
        params = { list: params }
        @config.put("/lists/#{list_id}", body: params)
      end

      def find(list_id)
        @config.get("/lists/#{list_id}")
      end
    end
  end
end
