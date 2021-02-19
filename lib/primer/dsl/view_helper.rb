# frozen_string_literal: true

require "active_support/concern"

module Primer
  # :nodoc:
  module DSL
    # DSL to allow components to register a View Helper for shorthand calls.
    #
    # Example:
    #
    # class MyComponent < ViewComponent::Base
    #   include Primer::DSL::ViewHelper
    #   view_helper :my_component
    # end
    module ViewHelper
      extend ActiveSupport::Concern

      class ViewHelperAlreadyDefined < StandardError; end

      included do
        class_attribute :helpers, instance_writer: false, default: {}
      end

      class_methods do
        def view_helper(name)
          raise ViewHelperAlreadyDefined if helpers[name].present?

          helpers[name] = self
        end
      end
    end
  end
end
