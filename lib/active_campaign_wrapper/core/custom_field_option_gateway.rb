# frozen_string_literal: true

module ActiveCampaignWrapper
  module Core
    class CustomFieldOptionGateway
      def initialize(client)
        @client = client
        @config = client.config
      end

      def create(params)
        params = { field_options: params }
        @config.post(
          '/fieldOption/bulk',
          body: ActiveCampaignWrapper::Helpers.normalize_body(
            params
          )
        )
      end

      def find(field_option_id)
        @config.get("/fieldOptions/#{field_option_id}")
      end

      def delete(field_option_id)
        @config.delete("/fieldOptions/#{field_option_id}")
      end
    end
  end
end
