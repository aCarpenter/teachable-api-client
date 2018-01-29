require 'rspec/core/rake_task'
require_relative './lib/teachable-api-client/api_client'
require_relative './lib/teachable-api-client/errors/api_error'

desc 'Run specs'
RSpec::Core::RakeTask.new(:spec)

desc 'Run integration tests'
task :integration_tests, %i(username password) do |_t, args|
  client = TeachableApiClient::ApiClient.new(args[:username], args[:password])
  puts client.token ? "token: #{client.token}" : 'error'
  lists = client.lists.index
  p '/lists', lists
  lists.map do |list|
    client.lists.delete list.id
  end
  my_list = client.lists.create name: 'listdddd'
  p 'create list', my_list
  p '/lists', client.lists.index
  p '/list', client.lists.show(my_list.id)
  p '/update', client.lists.update(my_list.id, name: 'some other nameii')
  p 'create item', client.list_items(my_list.id).create(name: 'item 1')
  p 'create item', client.list_items(my_list.id).create(name: 'item 2')
  # list item names are not unique per list
  p 'create item', client.list_items(my_list.id).create(name: 'item 2')
  p 'create item', client.list_items(my_list.id).create(name: 'item 3')
  my_list = client.lists.show(my_list.id)
  p '/list', my_list
  p 'finish', client.list_items(my_list.id).finish(my_list.items.first.id)
  p 'finish', client.list_items(my_list.id).finish(my_list.items[1].id)
  p 'delete', client.list_items(my_list.id).finish(my_list.items[2].id)
  # this should result in an error
  begin
    client.lists.create name: 'some other nameii'
  rescue TeachableApiClient::Errors::ApiError => e
    puts 'Error received!'
    puts e
  end
end
