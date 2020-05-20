# frozen_string_literal: true

require 'net/http'

module Interage
  module Request
    class Start
      def self.call(*args)
        new(*args).perbuilder
      end

      def initialize(klass, uri, params = {}, headers = {}, ssl = false)
        @klass = klass
        @uri = URI(uri.to_s)
        @params = params
        @headers = headers
        @ssl = ssl
      end

      def perbuilder
        @response = Net::HTTP.start(uri.host, uri.port) do |http|
          http.use_ssl = true if ssl?

          http.request(request)
        end

        self
      end

      def body
        @body ||= JSON.parse(response_body, symbolize_names: true)
      rescue JSON::ParserError
        {}
      end

      def code
        response_code.to_i
      end

      def success?
        response_message == 'OK' && errors.blank?
      end

      def errors
        body[:errors] || {}
      end

      protected

      attr_reader :response, :klass, :uri, :params, :headers, :ssl

      delegate :code, :body, :message,
               to: :response, allow_nil: true, prefix: true

      alias ssl? ssl

      def request
        @request ||= begin
          request = klass.new(uri)
          request.body = params.to_json
          request.content_type = 'application/json'
          headers.map { |key, value| request[key] = value }

          request
        end
      end
    end
  end
end
