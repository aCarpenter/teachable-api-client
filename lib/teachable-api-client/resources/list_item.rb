require 'cgi'

module TeachableApiClient
  module Resources
    class ListItem
      attr_accessor :client, :list_id

      def self.operations
        %i(create finish delete)
      end

      def initialize(client, list_id)
        @client = client
        @list_id = list_id
      end

      def create(params)
        client.authenticated_request(:post, route_for, { item: params }, json: true)
      end

      def finish(id)
        response = client.authenticated_request(:put, route_for(id, 'finish'))
        response.end_with? 'finished'
      end

      def delete(id)
        response = client.authenticated_request(:delete, route_for(id))
        response.end_with? 'finished'
      end

      private

      def route_for(*other_args)
        if other_args.empty?
          "lists/#{list_id}/items"
        else
          escaped_args = other_args.map { |arg| CGI.escape(arg) }
          "lists/#{list_id}/items/#{escaped_args.join('/')}"
        end
      end
    end
  end
end
