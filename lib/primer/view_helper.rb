# frozen_string_literal: true

module Primer
  # Module to allow shorthand calls for registered Primer components
  #
  # Registered components can be called with
  # `primer(:name, **kwargs) { block }` instead of
  # `render Primer::NameComponent.new(**kwargs) { block }`
  module ViewHelper
    extend ActiveSupport::Concern

    def primer(name, **component_args, &block)
      component = Primer::Component.helpers[name]

      raise ViewHelperNotFound if component.blank?

      render component.new(**component_args), &block
    end
  end
end
