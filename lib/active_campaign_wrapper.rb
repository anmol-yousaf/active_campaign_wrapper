# frozen_string_literal: true

require 'httparty'
require 'active_campaign_wrapper/version'
require 'active_campaign_wrapper/client'

module ActiveCampaignWrapper
  API_VERSION = 3

  class << self
    attr_accessor :api_token, :endpoint_url

    def config
      yield self
    end
  end

  class Error < StandardError; end

  class AuthorizationError < StandardError; end
end
