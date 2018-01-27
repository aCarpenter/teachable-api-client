require 'rspec/core/rake_task'
require_relative './lib/teachable-api-client/api_client'

desc 'Run specs'
RSpec::Core::RakeTask.new(:spec)

desc 'Test authentication'
task :integration_test, %i(username password) do |_t, args|
  client = TeachableApiClient::ApiClient.new(args[:username], args[:password])
  puts client.token ? "token: #{client.token}" : 'error'
end
