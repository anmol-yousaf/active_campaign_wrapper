# frozen_string_literal: true

RSpec.shared_context 'with task type params', with_task_type_params: true do
  let(:task_type_title) { 'Meeting' }
  let(:task_type_params) do
    {
      title: task_type_title
    }
  end

  let(:expected_task_type_response) do
    task_type_params
  end
end

RSpec.shared_context 'with existing task type', with_existing_task_type: true do
  include_context 'with task type params'
  let!(:client) { ActiveCampaignWrapper::Client.new }
  let!(:task_type) do
    response = client.task_types.create(task_type_params)
    response.fetch(:deal_tasktype) { raise "HELL (task_type creation failed) #{response}" }
  end
  let(:task_type_id) { task_type[:id] }

  after do
    client.task_types.delete(task_type_id) if task_type_id
  end
end
