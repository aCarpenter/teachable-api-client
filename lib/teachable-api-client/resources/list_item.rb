module TeachableApiClient
  module Resources
    class ListItem
      attr_accessor :token, :list_id

      def self.operations
        %i(create update delete)
      end

      def initialize(token, list_id)
        @token = token
        @list_id = list_id
      end
    end
  end
end
