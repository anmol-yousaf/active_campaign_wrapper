# frozen_string_literal: true

RSpec.shared_context 'with list params', with_list_params: true do
  let(:list_name)            { 'Awesome List' }
  let(:list_stringid)        { 'awesome-list' }
  let(:list_sender_url)      { 'https://workytical.com' }
  let(:list_sender_reminder) { 'This is why we are sending you this' }
  let(:list_params) do
    {
      name: list_name,
      stringid: list_stringid,
      sender_url: list_sender_url,
      sender_reminder: list_sender_reminder
    }
  end
  let(:expected_list_response) do
    list_params
  end
end

RSpec.shared_context 'with existing list', with_existing_list: true do
  include_context 'with list params'

  let!(:client) { ActiveCampaignWrapper::Client.new }
  let!(:list) do
    response = client.lists.create(list_params)
    response.fetch(:list) { raise "HELL (list creation failed) #{response}" }
  end
  let(:list_id) { list[:id] }

  after do
    client.lists.delete(list_id) if list_id
  end
end
