# frozen_string_literal: true

module Primer
  class DenyComponent < Primer::Component
    def initialize(**system_arguments)
      deny_single_argument(:class, "Use `classes` instead.", **system_arguments)
      deny_aria_key(:label, "Don't use labels?", **system_arguments)
    end

    def call
      "<p>foo</p>".html_safe
    end
  end
end
