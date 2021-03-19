# frozen_string_literal: true

module ActiveCampaignWrapper
  module Core
    class TagGateway
      def initialize(client)
        @client = client
        @config = client.config
      end

      def all(**params)
        @config.get('/tags', query: params)
      end

      def create(params)
        params = { tag: params }
        @config.post(
          '/tags',
          body: ActiveCampaignWrapper::Helpers.normalize_body(params)
        )
      end

      def delete(tag_id)
        @config.delete("/tags/#{tag_id}")
      end

      def update(tag_id, params)
        params = { tag: params }
        @config.put(
          "/tags/#{tag_id}", body:
          ActiveCampaignWrapper::Helpers.normalize_body(params)
        )
      end

      def find(tag_id)
        @config.get("/tags/#{tag_id}")
      end
    end
  end
end
