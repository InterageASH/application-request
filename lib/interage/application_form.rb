# frozen_string_literal: true

module Interage
  class ApplicationForm < ::Interage::Request::Form
    def self.paginate(*args)
      new.requester.paginate(*args)
    end

    def self.all(*args)
      new.requester.all(*args)
    end

    def self.find(*args)
      new.requester.find(*args)
    end

    def create(params = {})
      self.attributes = params

      return false if invalid?

      response = requester.create(changeable_attributes)

      mount_errors(response.errors)

      response.success?
    end

    def update(params = {})
      self.attributes = params

      return false if invalid?

      response = requester.update(id, changeable_attributes)

      mount_errors(response.errors)

      response.success?
    end

    def destroy
      response = requester.destroy(id)

      mount_errors(response.errors)

      response.success?
    end

    def requester
      raise ArgumentError,
            "requester is missing for #{self.class.superclass.name}"
    end

    private

    def changeable_attributes
      raise ArgumentError,
            "changeable_attributes is missing for #{self.class.superclass.name}"
    end
  end
end
