# frozen_string_literal: true

RSpec.shared_context 'with contact params', with_contact_params: true do
  let(:contact_first_name) { 'Anmol' }
  let(:contact_last_name)  { 'Yousaf' }
  let(:contact_email)      { 'anmolyousaf94@gmail.com' }
  let(:contact_phone)      { '+491735728523' }
  let(:contact_params) do
    {
      email: contact_email,
      first_name: contact_first_name,
      last_name: contact_last_name,
      phone: contact_phone
    }
  end

  let(:expected_contact_response) do
    contact_params
  end
end

RSpec.shared_context 'with existing contact', with_existing_contact: true do
  include_context 'with contact params'
  let!(:client) { ActiveCampaignWrapper::Client.new }
  let!(:contact) do
    response = client.contacts.create(contact_params)
    response.fetch(:contact) { raise "HELL (tag creation failed) #{response}" }
  end
  let(:contact_id) { contact[:id] }

  after do
    client.contacts.delete(contact_id) if contact_id
  end
end
