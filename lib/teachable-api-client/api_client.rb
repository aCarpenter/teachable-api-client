require 'rest-client'
require 'uri'

# Module wrapping all runtime-accessible code
module TeachableApiClient
  class ApiClient
    BASE_ROUTE = 'http://todoable.teachable.tech/api/'

    attr_accessor :username, :password, :token
    def initialize(username, password)
      @username = username
      @password = password
      authenticate
    end

    private

    def authenticate
      response = RestClient::Request.execute(
        method: :post,
        url: "#{BASE_ROUTE}authenticate",
        user: username,
        password: password
      )
      # TODO: maybe keep track of expires_at
      @token = response['token']
    rescue RestClient::Unauthorized => e
      # TODO: figure out what to do with exceptions
      puts '401 - Authentication failed', e.message
    end
  end
end
