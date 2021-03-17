# frozen_string_literal: true

module ActiveCampaignWrapper
  module Core
    class CustomFieldGateway
      def initialize(client)
        @client = client
        @config = client.config
      end

      def all(**params)
        @config.get('/fields', query: params)
      end

      def create(params)
        params = { field: params }
        @config.post('/fields', body: params)
      end

      def delete(field_id)
        @config.delete("/fields/#{field_id}")
      end

      def update(field_id, params)
        params = { field: params }
        @config.put("/fields/#{field_id}", body: params)
      end

      def find(field_id)
        @config.get("/fields/#{field_id}")
      end
    end
  end
end
