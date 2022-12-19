# frozen_string_literal: true

module Primer
  # Conditionally renders a `Primer::BaseComponent` around the given content. If the given condition
  # is true, a `Primer::BaseComponent` will render around the content. If the condition is false, only
  # the content is rendered.
  #
  # @example True conditional
  #   <%# condition is true, so content will be wrapped in a <span> tag
  #   <%= render Primer::ConditionalWrapper.new(condition: true, tag: :span, class: "foobar")) do %>
  #     <%# also rendered %>
  #     <p class="bazboo">Some text</p>
  #   <% end %>
  #
  # @example False conditional
  #   <%# condition is false so no <span> tag will render around the content (i.e. the <p> tag)
  #   <%= render(Primer::ConditionalWrapper.new(condition: false, tag: :span, class: "foobar")) do %>
  #     <%# this content will be rendered %>
  #     <p class="bazboo">Some text</p>
  #   <% end %>
  #
  # @param condition [Boolean] Whether or not to wrap the content in a `Primer::BaseComponent`.
  # @param base_component_arguments [Hash] The arguments to pass to `Primer::BaseComponent`.
  class ConditionalWrapper < Primer::Component
    def initialize(condition:, **base_component_arguments)
      @condition = condition
      @base_component_arguments = base_component_arguments
    end

    def call
      return content unless @condition

      BaseComponent.new(**@base_component_arguments).render_in(self) { content }
    end
  end
end
