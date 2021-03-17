# frozen_string_literal: true

require 'active_campaign_wrapper/configuration'
require 'active_campaign_wrapper/core/tag_gateway'
require 'active_campaign_wrapper/core/contact_gateway'
require 'active_campaign_wrapper/core/email_activity_gateway'
# require 'active_campaign_wrapper/core/contacts/tags'
# require 'active_campaign_wrapper/core/contacts/automations'
# require 'active_campaign_wrapper/core/contacts/score_values'

module ActiveCampaignWrapper
  class Client
    include Core

    attr_reader :config

    def initialize(endpoint_url: nil, api_token: nil)
      @config = Configuration.new(
        endpoint_url: endpoint_url,
        api_token: api_token
      )
    end

    def tags
      TagGateway.new(self)
    end

    def contacts
      ContactGateway.new(self)
    end

    def email_activities
      EmailActivityGateway.new(self)
    end
  end
end
