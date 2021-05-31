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

  # :nocov:
  class Error < StandardError
    attr_accessor :response

    def initialize(response)
      super
      @response = response
    end
  end

  class Forbidden < Error; end

  class UnprocessableEntity < Error; end

  class NotFound < Error; end

  class TooManyRequests < Error; end
  # :nocov:
end
