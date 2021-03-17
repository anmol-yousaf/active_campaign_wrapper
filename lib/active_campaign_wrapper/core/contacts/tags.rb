# frozen_string_literal: true

module ActiveCampaignWrapper
  module Core
    module Contacts
      module Tags
        def contact_tags(contact_id, **params)
          get("/contacts/#{contact_id}/contactTags", query: params)
        end

        def add_contact_tag(params)
          params = { contact_tag: params }
          post('/contactTags', body: params)
        end

        def remove_contact_tag(contact_tag_id)
          delete("/contactTags/#{contact_tag_id}")
        end
      end
    end
  end
end
