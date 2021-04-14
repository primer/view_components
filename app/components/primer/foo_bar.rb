module Primer
  # Add a description gere
  class FooBar < Primer::Component
    # @example Example goes here
    #
    #   <%= render(FooBar.new) { "Example" } %>
    #
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(**system_arguments)
      @system_arguments = system_arguments
    end
  end
end
