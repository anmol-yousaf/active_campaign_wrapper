# frozen_string_literal: true

module ActiveCampaignWrapper
  module API
    module Contact
      module Arguments
        DEFINED_WITH_UNDERSCORE = {
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
