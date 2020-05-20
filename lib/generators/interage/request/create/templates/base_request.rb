# frozen_string_literal: true

module <%= main_modulu %>
  class BaseRequest < ::ApplicationRequest
    private

    def api_base_url
      "#{ENV.fetch('<%= main_modulu.upcase %>_BASE_URL')}/v1/"
    end

    def headers
      { 'Authorization-Token': ENV.fetch('<%= main_modulu.upcase %>_AUTHORIZATION_TOKEN') }
    end
  end
end
