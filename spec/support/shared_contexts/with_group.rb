# frozen_string_literal: true

RSpec.shared_context 'with group params', with_group_params: true do
  let(:group_title)       { 'Awesome' }
  let(:group_description) { 'My really awesome group' }
  let(:group_params) do
    {
      title: group_title,
      descript: group_description
    }
  end
  let(:expected_group_response) do
    group_params
  end
end

RSpec.shared_context 'with existing group', with_existing_group: true do
  include_context 'with group params'

  let!(:client) { ActiveCampaignWrapper::Client.new }
  let!(:group) do
    response = client.groups.create(group_params)
    response.fetch(:group) { raise "HELL (group creation failed) #{response}" }
  end
  let(:group_id) { group[:id] }

  after do
    client.groups.delete(group_id) if group_id
  end
end
