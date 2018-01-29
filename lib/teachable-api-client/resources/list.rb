require 'cgi'

module TeachableApiClient
  module Resources
    class List
      attr_accessor :client

      def self.operations
        %i(index create show update delete)
      end

      def initialize(client)
        @client = client
      end

      def index
        # API returns an object with one key that points to an array.
        # We just extract the array
        client.authenticated_request(:get, route_for, nil, json: true).lists
      end

      def create(params)
        client.authenticated_request(:post, route_for, { list: params }, json: true)
      end

      def show(id)
        result = client.authenticated_request(:get, route_for(id), nil, json: true)
        # data doesn't contain object's own ID
        result.id = id
        result
      end

      def update(id, params)
        # This returns a string indicating the desired parameter(s) were updated.
        client.authenticated_request(:patch, route_for(id), list: params)
        true
      end

      def delete(id)
        # This returns a blank string on success
        client.authenticated_request(:delete, route_for(id))
        true
      end

      private

      def route_for(*other_args)
        if other_args.empty?
          'lists'
        else
          escaped_args = other_args.map { |arg| CGI.escape(arg) }
          "lists/#{escaped_args.join('/')}"
        end
      end
    end
  end
end
