# frozen_string_literal: true

module Interage
  module Request
    class Form
      include ActiveModel::Model

      attr_accessor :id, :created_at, :updated_at

      def initialize(attributes = {})
        mount_errors(attributes.delete(:errors))

        super(assigned_attributes(attributes))
      end

      def persisted?
        id.present?
      end

      protected

      def assigned_attributes(attributes)
        attributes.select { |attr_name, _| respond_to?(attr_name) }
      end

      def mount_errors(attr_errors)
        return if attr_errors.blank?

        attr_errors.each do |attr_name, errors|
          Array.wrap(errors).each { |error| self.errors.add(attr_name, error) }
        end
      end
    end
  end
end
