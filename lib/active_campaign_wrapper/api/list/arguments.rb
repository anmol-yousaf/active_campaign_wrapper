# frozen_string_literal: true

module ActiveCampaignWrapper
  module Api
    module List
      module Arguments
        SNAKE_CASED = {
          create: %i[
            sender_url
            sender_reminder
            send_last_broadcast
            subscription_notify
            unsubscription_notify
          ]
        }.freeze
      end
    end
  end
end
