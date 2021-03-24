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

### Initialize

You can specify your Endpoint URL and API token in a config file looking like this.

```ruby
ActiveCampaignWrapper.config do |config|
  config.endpoint_url = 'your-url'
  config.endpoint_url = 'your-token'
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
    endpoint_url: 'your-token'
})
```
---

### Tags - [Api Reference](https://developers.activecampaign.com/reference#tags)

#### Create a tag

```ruby
client.tags.create({
    tag: 'Tag Name',
    tag_type: 'contact',
    description: 'Tag description'
})
```
```
BODY PARAMS
- tag (string) : Name of the new tag
- tag_type (string): Tag-type of the new tag. Possible Values: template, contact.
- description (string): Description of the new tag
```
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
```
QUERY PARAMS (Optional)
- search (string): Filter by name of tag(s)
```

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
```
BODY PARAMS
- name* (string): Name of the list to create
- stringid* (string): URL-safe list name. Example: 'list-name-sample'
- sender_url* (string): The website URL this list is for.
- sender_reminder* (string): A reminder for your contacts as to why they are on this list and you are messaging them.
- send_last_broadcast (boolean): Boolean value indicating whether or not to send the last sent campaign to this list to a new subscriber upon subscribing. 1 = yes, 0 = no
- carboncopy (string): Comma-separated list of email addresses to send a copy of all mailings to upon send
- subscription_notify (string): Comma-separated list of email addresses to notify when a new subscriber joins this list.
- unsubscription_notify (string): Comma-separated list of email addresses to notify when a subscriber unsubscribes from this list.
- user (integer): User Id of the list owner. A list owner is able to control campaign branding. A property of list.userid also exists on this object; both properties map to the same list owner field and are being maintained in the response object for backward compatibility. If you post values for both list.user and list.userid, the value of list.user will be used.
```
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
```
QUERY PARAMS (Optional)
- filters[name] (string): Filter by the name of the list
```
---

### Sync contact (Create or Update) - [Api Reference](https://developers.activecampaign.com/reference#create-or-update-contact-new)

```ruby
client.sync_contact({
  contact: {
    email:     'contact@email.com',
    firstName: 'first',
    lastName:  'last',
    phone:     '12312312',
    fieldValues: [
      {
        field: '1',
        value: 'My Value'
      },
      {
        field: '2',
        value: 'My second value'
      }
    ]   
  }
})
```

### Retrieve contact - [Api Reference](https://developers.activecampaign.com/reference#get-contact)

```ruby
client.retrieve_contact("contact_id")
```

### Retrieve contact by email

This will return an array of contacts.

```ruby
client.retrieve_contact_by_email("email")
```

### Retrieve lists - [Api Reference](https://developers.activecampaign.com/reference#retrieve-all-lists)

```ruby
client.retrieve_lists
```

### Create tag - [Api Reference](https://developers.activecampaign.com/reference#tags)

```ruby
client.create_tag({ 
    tag: "tag_name", tagType: "tag_type"  
})
```

### Add a tag to contact - [Api Reference](https://developers.activecampaign.com/reference#create-contact-tag)

It generates a relationship called contactTag containing an id.

```ruby
client.add_contact_tag({ 
    contact: "contact_id", tag: "tag_id"
})
```

### Remove a tag to contact - [Api Reference](https://developers.activecampaign.com/reference#delete-contact-tag)

To remove a tag from contact just remove the relationship between them.

```ruby
client.remove_contact_tag("contact_tag_id)
```

### Create field value - [Api Reference](https://developers.activecampaign.com/reference#create-fieldvalue)

It generates a relationship called fieldVaalue containing an id.

```ruby
client.create_field_value(
  {
    contact: 572218,
    field: 2,
    value: 'field_value'
  }
)
```

### Update a field value - [Api Reference](https://developers.activecampaign.com/reference#update-a-custom-field-value-for-contact)

It updates a relationship called fieldVaalue containing an id.

```ruby
client.update_field_value(
  803_383,
  {
    contact: 572218,
    field: 2,
    value: 'new_field_value_put'
  }
)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/anmol-yousaf/active_campaign_wrapper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/anmol-yousaf/active_campaign_wrapper/blob/master/CODE_OF_CONDUCT.md).

## License

See the [LICENSE](https://opensource.org/licenses/MIT) file for more info.

## Code of Conduct

Everyone interacting in the ActiveCampaignWrapper project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/anmol-yousaf/active_campaign_wrapper/blob/master/CODE_OF_CONDUCT.md).
