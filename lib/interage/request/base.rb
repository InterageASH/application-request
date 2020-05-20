# frozen_string_literal: true

module Interage
  module Request
    class Base
      delegate :code, :body, :success?, :errors, to: :response

      protected

      attr_reader :response

      def base_path
        plural_key_name
      end

      def member_path(id)
        "#{base_path}/#{id}"
      end

      def base_url(path: nil)
        "#{api_base_url}#{path}"
      end

      def api_base_url
        raise ArgumentError,
              "api_base_url is missing for #{self.class.superclass.name}"
      end

      def collection_response
        body[plural_key_name.to_sym] || body || []
      end

      def plural_key_name
        key_name.to_s.pluralize
      end

      def member_response
        body[key_name.to_sym] || body || {}
      end

      def key_name
        klass.model_name.to_s.underscore
      end

      def klass
        Interage::Request::Builder
      end

      def get(*args)
        start(Net::HTTP::Get, *args)
      end

      def patch(*args)
        start(Net::HTTP::Patch, *args)
      end

      def post(*args)
        start(Net::HTTP::Post, *args)
      end

      def put(*args)
        start(Net::HTTP::Put, *args)
      end

      def delete(*args)
        start(Net::HTTP::Delete, *args)
      end

      def start(klass, path:, params: {})
        ::Interage::Request::Start.call(klass,
                                        base_url(path: path),
                                        params,
                                        headers)
      end

      def headers
        {}
      end
    end
  end
end
