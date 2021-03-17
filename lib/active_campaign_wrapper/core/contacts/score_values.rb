# frozen_string_literal: true

module ActiveCampaignWrapper
  module Core
    module Contacts
      module ScoreValues
        def contact_score_values(contact_id, **params)
          get("/contacts/#{contact_id}/scoreValues", query: params)
        end
      end
    end
  end
end
