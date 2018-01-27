require 'rest-client'
require 'uri'

# Module wrapping all runtime-accessible code
module TeachableApiClient
  class ApiClient
    BASE_ROUTE = 'http://todoable.teachable.tech/api/'

    attr_accessor :username, :password, :token
    def initialize(username, password, skip_auth = false)
      @username = username
      @password = password
      authenticate unless skip_auth
    end

    def authenticate
      request = RestClient::Request.new(
        method: :post,
        url: "#{BASE_ROUTE}authenticate",
        user: username,
        password: password,
        headers: {
          content_type: :json,
          accept: :json
        }
      )
      response = request.execute
      # TODO: maybe keep track of expires_at
      @token = response['token']
      response
    end
  end
end
