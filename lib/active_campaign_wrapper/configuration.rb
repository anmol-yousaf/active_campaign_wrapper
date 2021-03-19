# frozen_string_literal: true

require 'active_campaign_wrapper/helpers'

module ActiveCampaignWrapper
  class Configuration
    include HTTParty
    include Helpers

    attr_accessor :endpoint_url, :api_token

    format :json

    def initialize(endpoint_url: nil, api_token: nil)
      @endpoint_url = endpoint_url.presence || ActiveCampaignWrapper.endpoint_url
      @api_token = api_token.presence || ActiveCampaignWrapper.api_token

      self.class.base_uri "#{@endpoint_url}/api/#{ActiveCampaignWrapper::API_VERSION}"
      self.class.default_options.merge! headers: { api_token: @api_token }
    end

    def post(*args)
      safe_http_call do
        self.class.post(*args)
      end
    end

    def patch(*args)
      safe_http_call do
        self.class.patch(*args)
      end
    end

    def put(*args)
      safe_http_call do
        self.class.put(*args)
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
