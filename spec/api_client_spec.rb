require_relative './spec_helper'
require_relative '../lib/teachable-api-client/api_client'

describe 'API Client' do
  # TODO: remove this test and use vcr for actually mocking responses
  context 'When authenticating' do
    context 'When user supplies correct credentials', :vcr do
      let(:request) do
        client = TeachableApiClient::ApiClient.new(ENV['USERNAME'], ENV['PASSWORD'], true)
        client.authenticate
      end
      it 'should receive valid API token' do
        expect(request['token']).not_to be_nil
      end
    end
  end
end
