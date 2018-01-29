require 'json'
require_relative './api_error'

module TeachableApiClient
  module Errors
    class RecordInvalidError < ApiError
      attr_accessor :validation_errors
      def initialize(cause)
        super(cause)
        self.validation_errors = JSON.parse(cause.http_body)
      end

      def to_s
        validation_errors.map { |attr_name, problems| "#{attr_name}: #{problems.join(', ')}" }.join('; ')
      end
    end
  end
end
