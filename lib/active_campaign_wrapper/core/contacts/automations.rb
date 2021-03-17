# frozen_string_literal: true

module ActiveCampaignWrapper
  module Core
    module Contacts
      module Automations
        def contact_automations(contact_id, **params)
          get("/contacts/#{contact_id}/contactAutomations", query: params)
        end
      end
    end
  end
end
