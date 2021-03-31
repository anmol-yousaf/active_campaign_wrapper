# frozen_string_literal: true

module ActiveCampaignWrapper
  module Core
    class TaskTypeGateway
      def initialize(client)
        @client = client
        @config = client.config
      end

      def all(**params)
        @config.get('/dealTasktypes', query: params)
      end

      def create(params)
        params = { deal_tasktype: params }
        @config.post(
          '/dealTasktypes',
          body: ActiveCampaignWrapper::Helpers.normalize_body(params)
        )
      end

      def delete(task_type_id)
        @config.delete("/dealTasktypes/#{task_type_id}")
      end

      def update(task_type_id, params)
        params = { deal_tasktype: params }
        @config.put(
          "/dealTasktypes/#{task_type_id}", body:
          ActiveCampaignWrapper::Helpers.normalize_body(params)
        )
      end

      def find(task_type_id)
        @config.get("/dealTasktypes/#{task_type_id}")
      end

      def move_tasks(from_task_type_id, to_task_type_id)
        params = { deal_task: { deal_tasktype: to_task_type_id } }
        @config.put(
          "/dealTasktypes/#{from_task_type_id}/dealTasks",
          body: ActiveCampaignWrapper::Helpers.normalize_body(params)
        )
      end
    end
  end
end
