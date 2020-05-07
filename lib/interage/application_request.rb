# frozen_string_literal: true

module Interage
  class ApplicationRequest < ::Interage::Request::Base
    def paginate(page, params: {})
      all(params.merge(page: page))
    end

    def all(params = {})
      @response = get(path: base_path, params: params)

      collection_response.map { |attributes| klass.new(attributes) }
    end

    def create(params)
      post(path: base_path, params: params)
    end

    def find(id, params = {})
      @response = get(path: member_path(id), params: params)

      klass.new(member_response) if member_response.present?
    end

    def update(id, params = {})
      put(path: member_path(id), params: params)
    end

    def destroy(id, params = {})
      delete(path: member_path(id), params: params)
    end
  end
end
