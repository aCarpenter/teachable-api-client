# teachable-api-client
Client to interact with Teachable's Todoable API

## Installation
Until this gem is published to RubyGems, you will need to install this gem from a local `.gem` file.

### Building Gem From Source
You can `git clone` or download the source from this repository. Once downloaded, navigate to the directory and build the gem as follows:

(from within teachable-api-client)
`gem build teachable-api-client.gemspec`

You may link to the resulting `.gem` file to use it in your projects.

## Adding teachable-api-client as a dependency
### Using Bundler
Add the following entry to your `Gemfile`, adjusting the `path` to match the location of your gem file:
```
gem 'teachable-api-client', path: '/path/to/teachable-api-client-1.0.0.gem'
```
### Without Bundler
```
require 'path/to/teachable-api-client/lib/teachable-api-client/api_client'
```
You can reference `api_client.rb` from the source you downloaded or you can reference it from the unpacked version of the .gem file built earlier:
```
gem unpack teachable-api-client-1.0.0.gem
```

## Usage
### Authentication
You can instantiate the client using your username and password:
```
client = TeachableApiClient::ApiClient.new_from_credentials('my_username', 'my_password')
```
Or, if you already have a token, you can use it instead:
```
client = TeachableApiClient::ApiClient.new_from_token('my-api-token')
```
### Operations
Get all lists:
```
client.lists.index
```
Create a new list (called "my list"):
```
client.lists.create(name: 'my list')
```
Get one specific list with id `id`:
```
client.lists.show(id)
```
Update a list with id `id`:
```
client.lists.update(id, name: 'new name')
```
Delete a list with id `id`:
```
client.lists.delete(id)
```
Add a new item called "TODO" to list with id `id`:
```
client.list_items(id).create(name: 'TODO')
```
Delete item with id `item_id` from list with id `id`:
```
client.list_items(id).delete(item_id)
```
Mark item `item_id` as finished:
```
client.list_items(id).finish(item_id)
```

If your token expires and you used your username and password to authenticate, you can obtain a new token:
```
client.authenticate
```
