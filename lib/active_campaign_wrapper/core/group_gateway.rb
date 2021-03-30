# frozen_string_literal: true

module ActiveCampaignWrapper
  module Core
    class GroupGateway
      def initialize(client)
        @client = client
        @config = client.config
      end

      def all(**params)
        @config.get('/groups', query: params)
      end

      def create(params)
        params = { group: params }
        @config.post(
          '/groups',
          body: ActiveCampaignWrapper::Helpers.normalize_body(
            params,
            ActiveCampaignWrapper::Api::Group::Arguments::SNAKE_CASED[:create]
          )
        )
      end

      def delete(group_id)
        @config.delete("/groups/#{group_id}")
      end

      def update(group_id, params)
        params = { group: params }
        @config.put(
          "/groups/#{group_id}",
          body: ActiveCampaignWrapper::Helpers.normalize_body(
            params,
            ActiveCampaignWrapper::Api::Group::Arguments::SNAKE_CASED[:create]
          )
        )
      end

      def find(group_id)
        @config.get("/groups/#{group_id}")
      end
    end
  end
end
