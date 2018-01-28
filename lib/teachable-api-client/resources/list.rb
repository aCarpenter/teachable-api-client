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
        client.authenticated_request(:get, 'lists')
      end
    end
  end
end
