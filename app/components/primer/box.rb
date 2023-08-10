# frozen_string_literal: true

module Primer
  # `Box` is a basic wrapper component for most layout related needs.
  class Box < Primer::Component
    status :stable

    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(**system_arguments)
      @system_arguments = deny_tag_argument(**system_arguments)

      @system_arguments[:tag] = :div
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
