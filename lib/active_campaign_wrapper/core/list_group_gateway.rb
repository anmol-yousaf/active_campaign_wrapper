# frozen_string_literal: true

module ActiveCampaignWrapper
  module Core
    class ListGroupGateway
      def initialize(client)
        @client = client
        @config = client.config
      end

      def all(**params)
        @config.get('/listGroups', query: params)
      end

      def create(params)
        params = { list_group: params }
        @config.post(
          '/listGroups',
          body: ActiveCampaignWrapper::Helpers.normalize_body(params)
        )
      end

      def delete(list_group_id)
        @config.delete("/listGroups/#{list_group_id}")
      end

      def find(list_group_id)
        @config.get("/listGroups/#{list_group_id}")
      end
    end
  end
end
