# frozen_string_literal: true

module ActiveCampaignWrapper
  module Core
    class TemplateGateway
      def initialize(client)
        @client = client
        @config = client.config
      end

      def all(**params)
        @config.get('/templates', query: params)
      end

      def delete(template_id)
        @config.delete("/templates/#{template_id}")
      end

      def find(template_id)
        @config.get("/templates/#{template_id}")
      end
    end
  end
end
