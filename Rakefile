require_relative './lib/teachable-api-client/api_client'

desc 'Test authentication'
task :hello_world, %i(username password) do |_t, args|
  client = TeachableApiClient::ApiClient.new(args[:username], args[:password])
  puts client.token ? "token: #{client.token}" : 'error'
end
