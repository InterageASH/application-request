# frozen_string_literal: true

module Interage
  module Request
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      desc 'Generates a application request.'

      def create_application_request
        copy_file('application_request.rb', application_request_path)

        copy_file('application_builder.rb', application_builder_path)
      end

      private

      def application_request_path
        Rails.root.join('app/requests/application_request.rb')
      end

      def application_builder_path
        Rails.root.join('app/builders/application_builder.rb')
      end
    end
  end
end
