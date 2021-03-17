# frozen_string_literal: true

module ActiveCampaignWrapper
  module Core
    module Tags
      def tags(**params)
        get('/tags', query: params)
      end

      def create_tag(params)
        params = { tag: params }
        post('/tags', body: params)
      end

      def delete_tag(tag_id)
        delete("/tags/#{tag_id}")
      end

      def update_tag(tag_id, params)
        params = { tag: params }
        put("/tags/#{tag_id}", body: params)
      end

      def tag(tag_id)
        get("/tags/#{tag_id}")
      end
    end
  end
end
