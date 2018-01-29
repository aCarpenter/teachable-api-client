module TeachableApiClient
  module Errors
    class ApiError < StandardError
      attr_accessor :cause
      # This works differently from the StandardError constructor;
      # we take another error (the cause) instead of a string message.
      def initialize(cause)
        @cause = cause
      end
    end
  end
end
