# frozen_string_literal: true

module Primer
  # Conditionally renders a `Primer::BaseComponent` around the given content. If the given condition
  # is true, a `Primer::BaseComponent` will render around the content. If the condition is false, only
  # the content is rendered.
  class ConditionalWrapper < Primer::Component
    # @param condition [Boolean] Whether or not to wrap the content in a `Primer::BaseComponent`.
    # @param base_component_arguments [Hash] The arguments to pass to `Primer::BaseComponent`.
    def initialize(condition:, **base_component_arguments)
      @condition = condition
      @base_component_arguments = base_component_arguments
      @trim = !!@base_component_arguments.delete(:trim)
    end

    def call
      unless @condition
        return @trim ? trimmed_content : content
      end

      BaseComponent.new(trim: @trim, **@base_component_arguments).render_in(self) { content }
    end
  end
end
