# frozen_string_literal: true

module ActiveCampaignWrapper
  module Core
    class UserGateway
      def initialize(client)
        @client = client
        @config = client.config
      end

      def all(**params)
        @config.get('/users', query: params)
      end

      def create(params)
        params = { user: params }
        @config.post(
          '/users',
          body: ActiveCampaignWrapper::Helpers.normalize_body(params)
        )
      end

      def delete(user_id)
        @config.delete("/users/#{user_id}")
      end

      def update(user_id, params)
        params = { user: params }
        @config.put(
          "/users/#{user_id}", body:
          ActiveCampaignWrapper::Helpers.normalize_body(params)
        )
      end

      def find(user_id)
        @config.get("/users/#{user_id}")
      end

      def find_by_email(email)
        @config.get("/users/email/#{email}")
      end

      def find_by_username(username)
        @config.get("/users/username/#{username}")
      end

      def logged_in
        @config.get('/users/me')
      end
    end
  end
end
