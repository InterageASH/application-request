# frozen_string_literal: true

require 'net/http'

module Interage
  module Request
    class Start
      def self.call(*args)
        new(*args).perform
      end

      def initialize(klass, uri, ssl_certificate, params = {}, headers = {})
        @klass = klass
        @uri = URI(uri.to_s)
        @params = params
        @headers = headers
        @ssl_certificate = ssl_certificate
      end

      def perform
        http = Net::HTTP.new(uri.host, uri.port)

        if ssl?
          http.use_ssl = true
          http.ca_file = ssl_certificate
          http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        end

        @response = http.request(request)

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

      attr_reader :response, :klass, :uri, :params, :headers, :ssl_certificate

      delegate :code, :body, :message,
               to: :response, allow_nil: true, prefix: true

      def ssl?
        request.uri.scheme == 'https'
      end

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
