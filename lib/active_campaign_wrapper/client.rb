# frozen_string_literal: true

require 'active_campaign_wrapper/configuration'

require 'active_campaign_wrapper/core/tag_gateway'
require 'active_campaign_wrapper/core/contact_gateway'
require 'active_campaign_wrapper/core/email_activity_gateway'
require 'active_campaign_wrapper/core/list_gateway'
require 'active_campaign_wrapper/core/custom_field_gateway'
require 'active_campaign_wrapper/core/custom_field_option_gateway'
require 'active_campaign_wrapper/core/custom_field_value_gateway'
require 'active_campaign_wrapper/core/contact_tag_gateway'
require 'active_campaign_wrapper/core/contact_automation_gateway'
require 'active_campaign_wrapper/core/contact_score_value_gateway'
require 'active_campaign_wrapper/core/group_gateway'

require 'active_campaign_wrapper/api/contact/arguments'
require 'active_campaign_wrapper/api/list/arguments'
require 'active_campaign_wrapper/api/custom_field/arguments'
require 'active_campaign_wrapper/api/group/arguments'

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

    def contact_tags
      ContactTagGateway.new(self)
    end

    def contact_score_values
      ContactScoreValueGateway.new(self)
    end

    def contact_automations
      ContactAutomationGateway.new(self)
    end

    def custom_fields
      CustomFieldGateway.new(self)
    end

    def custom_field_options
      CustomFieldOptionGateway.new(self)
    end

    def custom_field_values
      CustomFieldValueGateway.new(self)
    end

    def lists
      ListGateway.new(self)
    end

    def groups
      GroupGateway.new(self)
    end
  end
end
