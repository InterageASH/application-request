# frozen_string_literal: true

module Interage
  module Request
    module Generators
      class CreateGenerator < Rails::Generators::NamedBase
        source_root File.expand_path('templates', __dir__)

        desc 'Generates a request and form.'

        def initialize(args, *_options)
          super

          @form_filename = args.first
          first_arg = form_filename.split('/')
          @modulu = first_arg.shift.camelize if first_arg.size > 1
          @form_name = first_arg.join('/').camelize
          @form_fullname = "/#{form_filename}".camelize
          @request_filename = "#{form_filename}_request"
        end

        def create_request
          create_file(new_request_file, sample_request_file)

          create_file(new_form_file, sample_form_file)
        end

        private

        attr_reader :modulu, :form_filename, :form_name, :form_fullname,
                    :request_filename, :request_name

        def new_request_file
          Rails.root.join("app/requests/#{request_filename}.rb")
        end

        def sample_request_file
          file = modulu.blank? ? 'request' : 'request_namespace'

          File.read(File.expand_path("templates/#{file}.rb", __dir__))
              .gsub('{{REQUEST_NAME}}', "#{form_name}Request".camelize)
              .gsub('{{FORM_NAME}}', form_fullname)
              .gsub('{{MODULU}}', modulu)
        end

        def new_form_file
          Rails.root.join("app/forms/#{form_filename}.rb")
        end

        def sample_form_file
          file = modulu.blank? ? 'form' : 'form_namespace'

          File.read(File.expand_path("templates/#{file}.rb", __dir__))
              .gsub('{{FORM_ATTRIBUTES}}', form_attributes)
              .gsub('{{FORM_NAME}}', form_name)
              .gsub('{{MODULU}}', modulu)
        end

        def form_attributes
          ":#{@args.join(', :')}"
        end
      end
    end
  end
end
