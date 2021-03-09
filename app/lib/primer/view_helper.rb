# frozen_string_literal: true

module Primer
  # Module to allow shorthand calls for Primer components
  module ViewHelper
    class ViewHelperNotFound < StandardError; end

    HELPERS = {
      octicon: "Primer::OcticonComponent",
      heading: "Primer::HeadingComponent"
    }.freeze

    HELPERS.each do |name, component|
      define_method "primer_#{name}" do |**component_args, &block|
        render component.constantize.new(**component_args), &block
      end
    end
  end
end
