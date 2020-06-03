# frozen_string_literal: true

require 'interage/request/version'
require 'active_support/core_ext/module'

module Interage
  module Request
    class Error < StandardError
    end

    autoload :Base, 'interage/request/base'
    autoload :Builder, 'interage/request/builder'
    autoload :Start, 'interage/request/start'
  end

  autoload :ApplicationBuilder, 'interage/application_builder'
  autoload :ApplicationRequest, 'interage/application_request'
end
