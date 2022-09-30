# frozen_string_literal: true

module Primer
  module Alpha
    # Add a general description of component here
    # Add additional usage considerations or best practices that may aid the user to use the component correctly.
    # @accessibility Add any accessibility considerations
    class SplitButton < Primer::Component
      status :alpha

      renders_one :button, lambda { |**kwargs|
        kwargs[:size] = @size
        kwargs[:scheme] = @scheme

        Primer::Beta::Button.new(**kwargs)
      }

      renders_one :icon_button, lambda { |**kwargs|
        kwargs[:size] = @size
        kwargs[:scheme] = @scheme
        # system_arguments[:classes] = class_names(
        #   "test",
        #   system_arguments[:classes]
        # )

        Primer::Beta::IconButton.new(**kwargs)
      }

      # @example Example goes here
      #
      #   <%= render(Primer::Alpha::SplitButton.new) { "Example" } %>
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(scheme: Primer::Beta::Button::DEFAULT_SCHEME, size: Primer::Beta::Button::DEFAULT_SIZE, **system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = "div"
        @size = size
        @scheme = scheme


        @system_arguments[:classes] = class_names(
          "SplitButton",
          system_arguments[:classes]
        )
      end

      # def render?
      #   button.any?
      # end
    end
  end
end
