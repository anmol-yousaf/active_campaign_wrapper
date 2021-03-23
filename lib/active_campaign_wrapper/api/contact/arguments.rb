# frozen_string_literal: true

module ActiveCampaignWrapper
  module Api
    module Contact
      module Arguments
        SNAKE_CASED = {
          bulk_import: %i[
            first_name
            last_name
            customer_acct_name
            detailed_results
          ]
        }.freeze
      end
    end
  end
end
