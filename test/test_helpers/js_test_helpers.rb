# frozen_string_literal: true

module Primer
  module JsTestHelpers
    def evaluate_multiline_script(script)
      page.evaluate_script(<<~JS)
        (() => { #{script} })()
      JS
    end
  end
end
