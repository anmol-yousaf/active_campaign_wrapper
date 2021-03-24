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

      def create(params, use_defaults: false)
        params = { field_value: params, use_defaults: use_defaults }
        @config.post(
          '/fieldValues',
          body: ActiveCampaignWrapper::Helpers.normalize_body(
            params
          )
        )
      end

      def delete(field_value_id)
        @config.delete("/fieldValues/#{field_value_id}")
      end

      def update(field_value_id, params, use_defaults: false)
        params = { field_value: params, use_defaults: use_defaults }
        @config.put(
          "/fieldValues/#{field_value_id}",
          body: ActiveCampaignWrapper::Helpers.normalize_body(
            params
          )
        )
      end

      def find(field_value_id)
        @config.get("/fieldValues/#{field_value_id}")
      end
    end
  end
end
