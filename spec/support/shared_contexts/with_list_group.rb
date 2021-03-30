# frozen_string_literal: true

RSpec.shared_context 'with list group params', with_list_group_params: true do
  include_context 'with existing list'
  include_context 'with existing group'

  let!(:list_id) { list[:id] }
  let!(:group_id) { group[:id] }
  let(:list_group_params) do
    {
      listid: list_id,
      groupid: group_id
    }
  end

  let(:expected_list_group_response) do
    {
      list: list_id,
      group: group_id
    }
  end
end

RSpec.shared_context 'with existing list group', with_existing_list_group: true do
  include_context 'with list group params'

  let!(:client) { ActiveCampaignWrapper::Client.new }
  let!(:list_group) do
    response = client.list_groups.create(list_group_params)
    response.fetch(:list_group) { raise "HELL (list group creation failed) #{response}" }
  end
  let(:list_group_id) { list_group[:id] }

  after do
    client.list_groups.delete(list_group_id) if list_group_id
  end
end
