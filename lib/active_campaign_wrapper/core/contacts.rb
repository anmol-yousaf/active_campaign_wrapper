# frozen_string_literal: true

module ActiveCampaignWrapper
  module Core
    module Contacts
      def contacts(**params)
        get('/contacts', query: params)
      end

      def create_contact(params)
        params = { contact: params }
        post('/contacts', body: params)
      end

      def sync_contact(params)
        params = { contact: params }
        post('/contact/sync', body: params)
      end

      def update_contact_list_status(params)
        params = { contact_list: params }
        post('/contactLists', body: params)
      end

      def contact_automations(contact_id, **params)
        get("/contacts/#{contact_id}/contactAutomations", query: params)
      end

      def contact_score(contact_id, **params)
        get("/contacts/#{contact_id}/scoreValues", query: params)
      end

      def create_contacts(params)
        post('/import/bulk_import', body: params)
      end

      def delete_contact(contact_id)
        delete("/contacts/#{contact_id}")
      end

      def update_contact(contact_id, params)
        params = { contact: params }
        put("/contacts/#{contact_id}", body: params)
      end

      def contact(contact_id)
        get("/contacts/#{contact_id}")
      end
    end
  end
end
