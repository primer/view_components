# frozen_string_literal: true

module Primer
  module JsonResponseTestHelpers
    def assert_json_response
      assert_current_path(/\.json$/)
      assert_equal json_mime_type, page.evaluate_script("document.contentType")
    end

    def json_response
      @json_response ||= JSON.parse(page.document.text)
    end

    private

    def json_mime_type
      @json_mime_type ||= Mime::Type.lookup("application/json")
    end
  end
end
