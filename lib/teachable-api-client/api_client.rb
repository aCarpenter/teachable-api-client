require 'json'
require 'rest-client'
require_relative './resources/list'
require_relative './resources/list_item'

# Module wrapping all runtime-accessible code
module TeachableApiClient
  class ApiClient
    BASE_ROUTE = 'http://todoable.teachable.tech/api'

    attr_accessor :username, :password, :token

    def lists
      Resources::List.new(self)
    end

    def list_items
      Resources::ListItem.new(self)
    end

    def initialize(username, password, skip_auth = false)
      @username = username
      @password = password
      authenticate unless skip_auth
    end

    def url_for(suffix)
      "#{BASE_ROUTE}/#{suffix}"
    end

    def authenticated_request(verb, endpoint, body_params = nil)
      params = {
        method: verb,
        url: url_for(endpoint),
        headers: {
          content_type: :json,
          accept: :json,
          authorization: "Token token=\"#{token}\""
        }
      }
      params[:headers].merge!(payload: body_params) if body_params
      JSON.parse(RestClient::Request.execute(params))
    end

    def authenticate
      request = RestClient::Request.new(
        method: :post,
        url: url_for('authenticate'),
        user: username,
        password: password,
        headers: {
          content_type: :json,
          accept: :json
        }
      )
      response = JSON.parse(request.execute)
      # TODO: maybe keep track of expires_at
      @token = response['token']
      response
    end
  end
end
