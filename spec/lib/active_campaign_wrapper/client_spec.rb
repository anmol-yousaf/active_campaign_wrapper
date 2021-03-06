# frozen_string_literal: true

RSpec.describe ActiveCampaignWrapper::Client do
  let(:client) do
    described_class.new
  end

  describe '.new' do
    it 'intializes a config object as an attribute' do
      expect(client.config).to be_a(ActiveCampaignWrapper::Configuration)
    end
  end

  describe '#tags' do
    it 'returns a TagGateway object' do
      expect(client.tags).to be_a(ActiveCampaignWrapper::Core::TagGateway)
    end
  end

  describe '#contacts' do
    it 'returns a ContactGateway object' do
      expect(client.contacts).to be_a(ActiveCampaignWrapper::Core::ContactGateway)
    end
  end

  describe '#email_activities' do
    it 'returns a ContactGateway object' do
      expect(client.email_activities).to be_a(ActiveCampaignWrapper::Core::EmailActivityGateway)
    end
  end

  describe '#contact_tags' do
    it 'returns a ContactTagGateway object' do
      expect(client.contact_tags).to be_a(ActiveCampaignWrapper::Core::ContactTagGateway)
    end
  end

  describe '#contact_score_values' do
    it 'returns a ContactScoreValueGateway object' do
      expect(client.contact_score_values).to be_a(ActiveCampaignWrapper::Core::ContactScoreValueGateway)
    end
  end

  describe '#contact_automations' do
    it 'returns a ContactAutomationGateway object' do
      expect(client.contact_automations).to be_a(ActiveCampaignWrapper::Core::ContactAutomationGateway)
    end
  end

  describe '#custom_fields' do
    it 'returns a CustomFieldGateway object' do
      expect(client.custom_fields).to be_a(ActiveCampaignWrapper::Core::CustomFieldGateway)
    end
  end

  describe '#custom_field_options' do
    it 'returns a CustomFieldOptionGateway object' do
      expect(client.custom_field_options).to be_a(ActiveCampaignWrapper::Core::CustomFieldOptionGateway)
    end
  end

  describe '#custom_field_values' do
    it 'returns a CustomFieldValueGateway object' do
      expect(client.custom_field_values).to be_a(ActiveCampaignWrapper::Core::CustomFieldValueGateway)
    end
  end

  describe '#lists' do
    it 'returns a ListGateway object' do
      expect(client.lists).to be_a(ActiveCampaignWrapper::Core::ListGateway)
    end
  end

  describe '#groups' do
    it 'returns a GroupGateway object' do
      expect(client.groups).to be_a(ActiveCampaignWrapper::Core::GroupGateway)
    end
  end

  describe '#list_groups' do
    it 'returns a ListGroupGateway object' do
      expect(client.list_groups).to be_a(ActiveCampaignWrapper::Core::ListGroupGateway)
    end
  end

  describe '#users' do
    it 'returns a UserGateway object' do
      expect(client.users).to be_a(ActiveCampaignWrapper::Core::UserGateway)
    end
  end

  describe '#templates' do
    it 'returns a TemplateGateway object' do
      expect(client.templates).to be_a(ActiveCampaignWrapper::Core::TemplateGateway)
    end
  end

  describe '#task_types' do
    it 'returns a TaskTypeGateway object' do
      expect(client.task_types).to be_a(ActiveCampaignWrapper::Core::TaskTypeGateway)
    end
  end
end
