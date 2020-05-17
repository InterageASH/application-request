# frozen_string_literal: true

require 'interage/request/version'
require 'active_support/core_ext/module'

module Interage
  module Request
    class Error < StandardError
    end

    autoload :Base, 'interage/request/base'
    autoload :Form, 'interage/request/form'
    autoload :Start, 'interage/request/start'
  end

  autoload :ApplicationForm, 'interage/application_form'
  autoload :ApplicationRequest, 'interage/application_request'
end
