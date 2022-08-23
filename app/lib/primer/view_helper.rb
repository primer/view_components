# frozen_string_literal: true

# :nocov:
module Primer
  # Module to allow shorthand calls for Primer components
  module ViewHelper
    class ViewHelperNotFound < StandardError; end

    HELPERS = {
      octicon: "Primer::OcticonComponent",
      heading: "Primer::Beta::Heading",
      time_ago: "Primer::TimeAgoComponent",
      image: "Primer::Image"
    }.freeze

    HELPERS.each do |name, component|
      define_method "primer_#{name}" do |*args, **kwargs, &block|
        render component.constantize.new(*args, **kwargs), &block
      end
    end
  end
end
