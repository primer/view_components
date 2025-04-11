# frozen_string_literal: true

module Primer
  # Conditionally renders a component around the given content. If the given condition
  # is true, the component will render around the content. If the condition is false, only
  # the content is rendered.
  class ConditionalWrapper < Primer::Component
    # @param condition [Boolean] Whether or not to wrap the content in a component.
    # @param component [Class] The component class to use as a wrapper, defaults to `Primer::BaseComponent`
    # @param base_component_arguments [Hash] The arguments to pass to the component.
    def initialize(condition:, component: Primer::BaseComponent, **base_component_arguments)
      @condition = condition
      @component = component
      @base_component_arguments = base_component_arguments
      @trim = !!@base_component_arguments.delete(:trim)
    end

    def call
      unless @condition
        return @trim ? trimmed_content : content
      end

      @component.new(trim: @trim, **@base_component_arguments).render_in(self) { content }
    end
  end
end
