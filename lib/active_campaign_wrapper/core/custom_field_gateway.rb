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
        @config.post(
          '/fields',
          body: ActiveCampaignWrapper::Helpers.normalize_body(
            params,
            ActiveCampaignWrapper::Api::CustomField::Arguments::SNAKE_CASED[:create]
          )
        )
      end

      def delete(field_id)
        @config.delete("/fields/#{field_id}")
      end

      def update(field_id, params)
        params = { field: params }
        @config.put(
          "/fields/#{field_id}",
          body: ActiveCampaignWrapper::Helpers.normalize_body(
            params,
            ActiveCampaignWrapper::Api::CustomField::Arguments::SNAKE_CASED[:create]
          )
        )
      end

      def find(field_id)
        @config.get("/fields/#{field_id}")
      end

      def link_to_list(field_id, list_id)
        params = { field_rel: { field: field_id, relid: list_id } }
        @config.post(
          '/fieldRels',
          body: ActiveCampaignWrapper::Helpers.normalize_body(
            params
          )
        )
      end
    end
  end
end
