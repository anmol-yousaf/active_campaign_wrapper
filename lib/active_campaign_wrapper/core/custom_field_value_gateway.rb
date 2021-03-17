# frozen_string_literal: true

module ActiveCampaignWrapper
  module Core
    class CustomFieldValueGateway
      def initialize(client)
        @client = client
        @config = client.config
      end

      def all(**params)
        @config.get('/fieldValues', query: params)
      end

      def create(params)
        @config.post('/fieldValues', body: params)
      end

      def delete(field_value_id)
        @config.delete("/fieldValues/#{field_value_id}")
      end

      def update(field_value_id, params)
        @config.put("/fieldValues/#{field_value_id}", body: params)
      end

      def find(field_value_id)
        @config.get("/fieldValues/#{field_value_id}")
      end
    end
  end
end
