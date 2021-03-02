# frozen_string_literal: true

require "active_support/concern"

module Primer
  # :nodoc:
  module ViewHelper
    # DSL to allow components to register a View Helper for shorthand calls.
    #
    # Example:
    #
    # class MyComponent < ViewComponent::Base
    #   include Primer::ViewHelper::Dsl
    #   view_helper :my_component
    # end
    module Dsl
      extend ActiveSupport::Concern

      class ViewHelperAlreadyDefined < StandardError; end

      included do
        class_attribute :primer_helpers, instance_writer: false, default: {}
      end

      class_methods do
        def view_helper(name)
          raise ViewHelperAlreadyDefined, "#{name} is already defined" if primer_helpers[name].present?

          primer_helpers[name] = self
        end
      end
    end
  end
end
