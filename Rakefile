require 'rspec/core/rake_task'
require_relative './lib/teachable-api-client/api_client'
require_relative './lib/teachable-api-client/errors/api_error'

desc 'Run specs'
RSpec::Core::RakeTask.new(:spec)

# helper method to clean up after integration tests
desc 'Delete everything'
task :delete_everything, %i(token) do |_t, args|
  client = TeachableApiClient::ApiClient.new_from_token(args[:token])
  lists = client.lists.index
  p '/lists', lists
  lists.map do |list|
    client.lists.delete list.id
  end
end
