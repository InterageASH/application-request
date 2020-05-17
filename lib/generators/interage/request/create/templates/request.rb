# frozen_string_literal: true

class {{REQUEST_NAME}} < ApplicationRequest
  private

  def klass
    {{FORM_NAME}}
  end
end
