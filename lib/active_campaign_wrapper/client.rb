# frozen_string_literal: true

require 'active_campaign_wrapper/helpers'
require 'active_campaign_wrapper/core/tags'
require 'active_campaign_wrapper/core/contacts'
require 'active_campaign_wrapper/core/contacts/tags'

module ActiveCampaignWrapper
  class Client
    include HTTParty
    include Helpers
    include Core::Tags
    include Core::Contacts
    include Core::Contacts::Tags

    format :json

    def initialize(endpoint_url: nil, api_token: nil)
      endpoint_url ||= ActiveCampaignWrapper.endpoint_url
      api_token ||= ActiveCampaignWrapper.api_token

      self.class.base_uri "#{endpoint_url}/api/#{ActiveCampaignWrapper::API_VERSION}"
      self.class.default_options.merge! headers: { api_token: api_token }
    end

    def post(*args)
      safe_http_call do
        self.class.post(*normalize_body(args))
      end
    end

    def patch(*args)
      safe_http_call do
        self.class.patch(*normalize_body(args))
      end
    end

    def put(*args)
      safe_http_call do
        self.class.put(*normalize_body(args))
      end
    end

    def delete(*args)
      safe_http_call do
        self.class.delete(*args)
      end
    end

    def get(*args)
      safe_http_call do
        self.class.get(*args)
      end
    end

    private

    def safe_http_call
      response = yield
      normalize_response(response)
    end
  end
end
