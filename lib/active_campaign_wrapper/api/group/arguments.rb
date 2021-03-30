# frozen_string_literal: true

module ActiveCampaignWrapper
  module Api
    module Group
      module Arguments
        SNAKE_CASED = {
          create: %i[
            pg_user_add
            pg_user_edit
            pg_user_delete
          ]
        }.freeze
      end
    end
  end
end
