# frozen_string_literal: true

RSpec.describe ActiveCampaignWrapper::Core::TaskTypeGateway, :vcr do
  let(:task_type_gateway) do
    described_class.new(ActiveCampaignWrapper::Client.new)
  end

  describe '#all', :with_existing_task_type do
    subject(:response) { task_type_gateway.all }

    it 'returns a task type list hash' do
      expect(response).to include_json(deal_tasktypes: [{}, expected_task_type_response])
    end
  end

  describe '#create', :with_task_type_params do
    subject(:response) { task_type_gateway.create(task_type_params) }

    after do
      task_type_gateway.delete(response.dig(:deal_tasktype, :id))
    end

    it 'returns a task type hash' do
      expect(response).to include_json(deal_tasktype: expected_task_type_response)
    end
  end

  describe '#delete', :with_task_type_params do
    subject(:response) { task_type_gateway.delete(created_task_type_id) }

    let!(:created_task_type_id) do
      response = task_type_gateway.create(task_type_params)
      response.dig(:deal_tasktype, :id)
    end

    it 'returns an empty hash' do
      expect(response).to eq({})
    end
  end

  describe '#update', :with_existing_task_type do
    subject(:response) { task_type_gateway.update(task_type_id, update_params) }

    let(:new_task_type_title) { 'New Cool Title' }
    let(:update_params) do
      {
        title: new_task_type_title
      }
    end

    let(:expected_task_type_update_response) do
      update_params
    end

    it 'returns a task type hash' do
      expect(response).to include_json(deal_tasktype: expected_task_type_update_response)
    end
  end

  describe '#find', :with_existing_task_type do
    subject(:response) { task_type_gateway.find(task_type_id) }

    it 'returns a task type hash' do
      expect(response).to include_json(deal_tasktype: expected_task_type_response)
    end
  end

  describe '#move_tasks', :with_existing_task_type do
    subject(:response) { task_type_gateway.move_tasks(task_type_id, move_task_type_id) }

    let!(:move_task_type_id) { task_type_gateway.create(title: 'Cool Task Type').dig(:deal_tasktype, :id) }

    after do
      client.task_types.delete(move_task_type_id) if task_type_id
    end

    it 'returns a deal tasks hash' do
      expect(response).to include_json(deal_tasks: [])
    end
  end
end
