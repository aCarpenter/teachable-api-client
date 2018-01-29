require 'json'
require 'ostruct'
require 'rest-client'
require_relative './resources/list'
require_relative './resources/list_item'
require_relative './errors/record_invalid_error'

# Module wrapping all runtime-accessible code
module TeachableApiClient
  class ApiClient
    BASE_ROUTE = 'http://todoable.teachable.tech/api'

    attr_accessor :username, :password, :token

    def self.from_token(token)
      client = new
      client.token = token
      client
    end

    def self.from_credentials(username, password, skip_auth = false)
      client = new
      client.username = username
      client.password = password
      client.authenticate unless skip_auth
    end

    def lists
      Resources::List.new(self)
    end

    def list_items(list_id)
      Resources::ListItem.new(self, list_id)
    end

    def url_for(suffix)
      "#{BASE_ROUTE}/#{suffix}"
    end

    def authenticated_request(verb, endpoint, body_params = nil, opts = {})
      params = {
        method: verb,
        url: url_for(endpoint),
        headers: {
          content_type: :json,
          accept: :json,
          authorization: "Token token=\"#{token}\""
        }
      }
      params.merge!(payload: body_params.to_json) if body_params
      request = RestClient::Request.new(params)
      response = request.execute
      # not all responses are encoded in JSON
      if opts[:json]
        JSON.parse(response, object_class: OpenStruct)
      else
        response
      end
    rescue RestClient::UnprocessableEntity => e
      raise TeachableApiClient::Errors::RecordInvalidError.new(e), e.message
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
      # TODO: keep track of expires_at, automatically re-authenticate
      @token = response['token']
      response
    end
  end
end
