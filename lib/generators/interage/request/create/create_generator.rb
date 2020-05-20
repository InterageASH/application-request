# frozen_string_literal: true

module Interage
  module Request
    module Generators
      class CreateGenerator < Rails::Generators::NamedBase
        source_root File.expand_path('templates', __dir__)

        desc 'Generates a request and builder.'

        def initialize(args, *_options)
          super

          @tab = '  '
          @arguments = args
          @request_param = arguments.shift.to_s.underscore
        end

        def create_request
          if create_base_request?
            template('base_request.rb', new_base_request_file)
          end

          template('request.rb', new_request_file)

          template('builder.rb', new_builder_file)
        end

        private

        attr_reader :tab, :arguments, :request_param

        def create_base_request?
          !File.exist?(new_base_request_file) && modulu_exists?
        end

        def new_base_request_file
          Rails.root.join("app/requests/#{base_request_path}.rb")
        end

        def base_request_path
          "#{main_modulu.underscore}/base_request"
        end

        def new_request_file
          Rails.root.join("app/requests/#{request_path}.rb")
        end

        def request_path
          @request_path ||= begin
            path =
              request_param.gsub(prefix_class_name, prefix_class_name.pluralize)
            "#{path}_request"
          end
        end

        def request_class
          @request_class ||= request_path.split('/').last.camelize
        end

        def request_full_class
          (modulus + [request_class]).join('::')
        end

        def new_builder_file
          Rails.root.join("app/builders/#{prefix_class_name}.rb")
        end

        def builder_class
          @builder_class ||= builder_full_class.split('::').last
        end

        def builder_full_class
          @builder_full_class ||= prefix_class_name.camelize
        end

        def builder_accessors
          ":#{arguments.join(",\n#{tabs(modulus.count + 8)}:")}"
        end

        def builder_changeable_attributes
          arguments.map { |argument| "#{argument}: #{argument}" }
                   .join(",\n#{tabs(modulus.count + 3)}")
        end

        def request_extend_class
          modulu_exists? ? base_request_path.camelize : 'ApplicationRequest'
        end

        def modulu_exists?
          main_modulu.present?
        end

        def main_modulu
          modulus.first.to_s
        end

        def modulus_init
          0.upto(modulus.count - 1).map do |i|
            "#{tabs(i)}module #{modulus[i]}"
          end
        end

        def modules_end
          modulus.count.downto(1).map { |i| "#{tabs(i - 1)}end" }
        end

        def modulus
          @modulus ||= begin
            names = builder_full_class.split('::')

            names.take(names.count - 1)
          end
        end

        def tabs(size = nil)
          tab * (size || modulus.count).to_i
        end

        def prefix_class_name
          @prefix_class_name ||= request_param.split('_by_').first
        end
      end
    end
  end
end
