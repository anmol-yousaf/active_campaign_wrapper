# ActiveCampaignWrapper

[![Build Status](https://travis-ci.com/anmol-yousaf/active_campaign_wrapper.svg?branch=main)](https://travis-ci.com/anmol-yousaf/active_campaign_wrapper)
[![Test Coverage](https://codecov.io/gh/anmol-yousaf/active_campaign_wrapper/graph/badge.svg)](https://codecov.io/gh/anmol-yousaf/active_campaign_wrapper)

This library is designed to help ruby/rails based applications communicate with the publicly available REST API for ActiveCampaign.

If you are unfamiliar with the ActiveCampaign REST API, you should first read the documentation located at https://developers.activecampaign.com/reference.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_campaign_wrapper'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install active_campaign_wrapper

## Usage

##### Table of Contents

* [Initialize](#initialize)
* [Tags](#tags)
* [Lists](#lists)
* [Contacts](#tags)
* [Contact Tags](#contact-tags)
* [Contact Automations](#contact-automations)
* [Contact Score Values](#contact-score-values)
* [Custom Fields](#custom-fields)
* [Custom Field Options](#custom-field-options)
* [Custom Field Values](#custom-field-values)
* [Email Activities](#email-activities)


<a name="initialize"/>

### Initialize

You can specify your Endpoint URL and API token in a config file looking like this.

```ruby
ActiveCampaignWrapper.config do |config|
  config.endpoint_url = 'your-url'
  config.api_token = 'your-token'
end
```
and then initialize the client like

```ruby
client = ActiveCampaignWrapper::Client.new
```
OR

You can pass the Endpoint URL and API token directly to the client.

```ruby
client = ActiveCampaignWrapper::Client.new({
  endpoint_url: 'your-url',
  api_token: 'your-token'
})
```
<a name="tags"/>

### Tags - [Api Reference](https://developers.activecampaign.com/reference#tags)

#### Create a tag

```ruby
client.tags.create({
  tag: 'Tag Name',
  tag_type: 'contact',
  description: 'Tag description'
})
```
**BODY PARAMS**
- tag (string) : Name of the new tag
- tag_type (string): Tag-type of the new tag. Possible Values: template, contact.
- description (string): Description of the new tag

#### Retrieve a tag

```ruby
client.tags.find(tag_id)
```

#### Update a tag

```ruby
client.tags.update(tag_id, {
  tag: 'Updated Tag Name'
})
```

#### Delete a tag

```ruby
client.tags.delete(tag_id)
```

#### List all tags

```ruby
client.tags.all
```

**QUERY PARAMS** (Optional)
- search (string): Filter by name of tag(s)

<a name="lists"/>

### Lists - [Api Reference](https://developers.activecampaign.com/reference#lists)

#### Create a list

```ruby
client.lists.create({
  name: 'New List',
  stringid: 'new-list',
  sender_url:'https://workytical.com',
  sender_reminder: 'You are getting this notification as you have subscribed to our list.'
})
```
**BODY PARAMS**
- name* (string): Name of the list to create
- stringid* (string): URL-safe list name. Example: 'list-name-sample'
- sender_url* (string): The website URL this list is for.
- sender_reminder* (string): A reminder for your contacts as to why they are on this list and you are messaging them.
- send_last_broadcast (boolean): Boolean value indicating whether or not to send the last sent campaign to this list to a new subscriber upon subscribing. 1 = yes, 0 = no
- carboncopy (string): Comma-separated list of email addresses to send a copy of all mailings to upon send
- subscription_notify (string): Comma-separated list of email addresses to notify when a new subscriber joins this list.
- unsubscription_notify (string): Comma-separated list of email addresses to notify when a subscriber unsubscribes from this list.
- user (integer): User Id of the list owner. A list owner is able to control campaign branding. A property of list.userid also exists on this object; both properties map to the same list owner field and are being maintained in the response object for backward compatibility. If you post values for both list.user and list.userid, the value of list.user will be used.

#### Retrieve a list

```ruby
client.lists.find(list_id)
```

#### Update a list

```ruby
client.lists.update(list_id, {
  name: 'Updated List Name'
})
```

#### Delete a list

```ruby
client.lists.delete(list_id)
```

#### Retrieve all lists

```ruby
client.lists.all
```

**QUERY PARAMS** (Optional)
- filters[name]  (string): Filter by the name of the list.

<a name="contacts"/>

#### Contacts - [Api Reference](https://developers.activecampaign.com/reference#contact)

#### Create a contact

```ruby
client.contacts.create({
  email: 'contact@email.com',
  first_name:'first',
  last_name: 'last'
})
```

**BODY PARAMS**
- email* (string): Email address of the new contact. Example: 'test@example.com'
- status (integer) Status of your contact. Possible Values: -1..3
  - -1 Any
  - 0 Unconfirmed
  - 1 Active
  - 2 Unsubscribed
  - 3 Bounced
- first_name (string): First name of the new contact.
- last_name (string): Last name of the new contact.
- phone (integer): Phone number of the contact.
- field_values (array): Array of contact's custom field values  [{field, value}]

#### Create or update contact

```ruby
client.contacts.sync({
  email: 'contact@email.com',
  first_name:'first',
  last_name: 'last'
})
```

#### Update list status for a contact

```ruby
client.contacts.update_list_status({
  list: list_id,
  contact: contact_id,
  status: 1
})
```

**BODY PARAMS**
- list* (string/integer):ID of the list to subscribe the contact to
- contact* (string/integer): ID of the contact to subscribe to the list
- status* (string/integer): Set to "1" to subscribe the contact to the list. Set to "2" to unsubscribe the contact from the list. WARNING: If you change a status from unsubscribed to active, you can re-subscribe a contact to a list from which they had manually unsubscribed.
- sourceid (integer): Set to "4" when re-subscribing a contact to a list

#### Retrieve a contact

```ruby
client.contacts.find(contact_id)
```

#### Update a contact

```ruby
client.contacts.update(contact_id, {
  first_name: 'Updated Contact Name'
})
```

#### Delete a contact

```ruby
client.contacts.delete(contact_id)
```

#### Retrieve all contacts

```ruby
client.contacts.all
```

**QUERY PARAMS** (Optional)
- ids (string): Filter contacts by ID.
- email (string): Email address of the contact you want to get
- email_like (string): Filter contacts that contain the given value in the email address
- exclude (integer): Exclude from the response the contact with the given ID
- formid (integer): Filter contacts associated with the given form
- id_greater (integer): Only include contacts with an ID greater than the given ID
- id_less (integer): Only include contacts with an ID less than the given ID
- listid (string): Filter contacts associated with the given list
- search (string): Filter contacts that match the given value in the contact names, organization, phone or email
- segmentid (integer): Return only contacts that match a list segment (this param initially returns segment information, when it is run a second time it will return contacts that match the segment)
- seriesid (integer): Filter contacts associated with the given automation
- status (integer): -1..3
- tagid (integer): Filter contacts associated with the given tag
- filters[created_before]  (date) Filter contacts that were created prior to this date
- filters[created_after]  (date): Filter contacts that were created after this date
- filters[updated_before]  (date): Filter contacts that were updated before this date
- filters[updated_after]  (date): Filter contacts that were updated after this date
- waitid (integer): Filter by contacts in the wait queue of an automation block
- orders[cdate]  (string): Order contacts by creation date
- orders[email]  (string): Order contacts by email
- orders[first_name]  (string): Order contacts by first name
- orders[last_name]  (string): Order contacts by last name
- orders[name]  (string): Order contacts by full name
- orders[score]  (string): Order contacts by score
- in_group_lists (string): Set this to "true" in order to return only contacts that the current user has permissions to see.

#### Bulk import contacts

```ruby
client.contacts.bulk_import({
  contacts: [
    {
      email: 'someone@somewhere.com',
      first_name: 'Jane',
      last_name: 'Doe',
      phone: '123-456-7890',
      customer_acct_name: 'ActiveCampaign',
      tags: [
        'dictumst aliquam augue quam sollicitudin rutrum'
      ]
    }
  ],
  callback: {
    url: "www.your_web_server.com",
    request_type: "POST",
    detailed_results: "true",
    params: [
      { "key": "", "value": "" }
    ],
    headers: [
      { "key": "", "value": "" }
    ]
  }
})
```

**BODY PARAMS**
- contacts* (array of objects): An array of objects containing information about a single contact. Up to 250 contacts may be included in a single request. The suggested minimum number of contacts is 10. If less than that, then contact/sync api request should be used.
- callback (object): Callback function to notify users when an import is complete.
- url (string): The URL endpoint which the importer will make a request to once the import has completed.
- request_type (string): Can be set to either “GET” or “POST”. Determines the type of HTTP request which will be sent to the specified endpoint.
- detailed_results (string): When set to “true” and the requestType parameter is set to “POST”, the callback will include the number of successes and failures in the originating request, as well as an array of error messages for each failed contact.
- params (array of objects): A list of parameters to include in the callback request. Add each parameter in the form of a key-value pair. For a GET request, each parameter will be appended to the end of the URL in a query string. For a POST request, parameters will be included in the body of the request.
- headers (array of objects): A list of headers to include in the callback request. Add each header in the form of a key-value pair.

<a name="#contact-tags"/>

### Contact Tags - [Api Reference](https://developers.activecampaign.com/reference#contact-tags)

#### Retrieve all tags of a contact

```ruby
client.contact_tags.all(contact_id)
```

#### Add a tag to a contact

```ruby
client.contact_tags.create({
  contact: contact_id,
  tag: tag_id
})
```
**BODY PARAMS**
- contact* (integer): Contact's id
- tag* (integer): Tag's id

#### Retrieve a contact tag

```ruby
client.contact_tags.find(contact_tag_id)
```

#### Remove a tag from a contact

```ruby
client.contact_tags.delete(contact_tag_id)
```
<a name="#contact-automations"/>

### Contact Automations - [Api Reference](https://developers.activecampaign.com/reference#list-all-contactautomations-for-contact)

#### List all automations the contact is in

```ruby
client.contact_automations.all(contact_id)
```

<a name="#contact-score-values"/>

### Contact Score Values - [Api Reference](https://developers.activecampaign.com/reference#list-all-contactautomations-for-contact)

#### Retrieve a contact's score values

```ruby
client.contact_score_values.all(contact_id)
```

<a name="#email-activities"/>

### Email Activities - [Api Reference](https://developers.activecampaign.com/reference#email-emailactivities)

#### Retrieve all email activities

```ruby
client.email_activities.all
```

**QUERY PARAMS** (Optional)
- filters[subscriberid]  (integer): Set this parameter to return only email activities belonging to a given subscriber.
- filters[dealId]  (integer): Set this parameter to return only email activities belonging to a given deal.

<a name="#custom-fields"/>

### Custom Fields - [Api Reference](https://developers.activecampaign.com/reference#fields)

#### Create a custom field

```ruby
client.custom_fields.create({
  type: "textarea",
  title: "Field Title",
  descript: "Field description",
  perstag: "Personalized Tag",
  defval: "Defaut Value",
  visible: 1,
  ordernum: 1
})
```

**BODY PARAMS**
- title* (string): Title of the field being created
- type* (string): Possible Values: dropdown, hidden, checkbox, date, text, datetime, textarea, NULL, listbox, radio
- descript (string): Description of field being created
- perstag (string): The perstag that represents the field being created
- defval (string): Default value of the field being created
- show_in_list (boolean): Show this field in the contact list view (Deprecated - no longer used)
- visible (boolean): Show or hide this field when using the Form Builder
- service (string): Possible Vales: nimble, contactually, mindbody, salesforce, highrise, google_spreadsheets, pipedrive, onepage, google_contacts, freshbooks, shopify, zendesk, etsy, NULL, bigcommerce, capsule, bigcommerce_oauth, sugarcrm, zohocrm, batchbook
- ordernum (integer): Order of appearance in ‘My Fields’ tab.

#### Retrieve a custom field

```ruby
client.custom_fields.find(field_id)
```

#### Update a custom field

```ruby
client.custom_fields.update(field_id, {
  title: 'Updated Field Title'
})
```

#### Delete a custom field

```ruby
client.custom_fields.delete(field_id)
```

#### Retrieve all custom fields

```ruby
client.custom_fields.all
```

**QUERY PARAMS** (Optional)
- limit (integer): The number of fields returned per request.

<a name="#custom-field-options"/>

### Custom Fields Options - [Api Reference](https://developers.activecampaign.com/reference#create-custom-field-options)

#### Create custom field options

```ruby
client.custom_field_options.create([
  {
    field: custom_field_id,
    label: option_1_title,
    value: option_1_value
  },
  {
    field: custom_field_id,
    label: option_2_title,
    value: option_2_value
  }
])
```

**BODY PARAMS**
- field* (integer): ID of the custom field to add options to
- label (string): Name of the option
- value* (string): Value of the option
- orderid (integer): Order for displaying the custom field option
- isdefault: Whether or not this option is the default value

#### Retrieve a custom field option

```ruby
client.custom_field_options.find(field_option_id)
```

#### Delete a custom field option 

```ruby
client.custom_field_options.delete(field_option_id)
```

<a name="#custom-field-values"/>

### Custom Fields Values - [Api Reference](https://developers.activecampaign.com/reference#fieldvalues)

#### Create a custom field value

```ruby
client.custom_field_values.create({
  contact: contact_id,
  field: field_id,
  value: value
}, useDefaults: true)
```

**BODY PARAMS**
- contact* (string/integer): ID of the contact whose field value you're updating
- field* (string/integer): ID of the custom field whose value you're updating for the contact
- value* (string): Value for the field that you're updating. For multi-select options this needs to be in the format of ||option1||option2||
- useDefaults: If true, this will populate the missing required fields for this contact with default values

#### Retrieve a custom field value

```ruby
client.custom_field_values.find(field_value_id)
```

#### Update a custom field value

```ruby
client.custom_field_values.update(
  field_value_id,
  { value: value },
  use_defaults: false
)
```

#### Delete a custom field value 

```ruby
client.custom_field_values.delete(field_value_id)
```

#### Retrieve all custom field values

```ruby
client.custom_field_values.all
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/anmol-yousaf/active_campaign_wrapper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/anmol-yousaf/active_campaign_wrapper/blob/master/CODE_OF_CONDUCT.md).

## License

See the [LICENSE](https://opensource.org/licenses/MIT) file for more info.

## Code of Conduct

Everyone interacting in the ActiveCampaignWrapper project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/anmol-yousaf/active_campaign_wrapper/blob/master/CODE_OF_CONDUCT.md).
