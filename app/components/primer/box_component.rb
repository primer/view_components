# frozen_string_literal: true

module Primer
  # A basic wrapper component for most layout related needs.
  class BoxComponent < Primer::Component
    # @param kwargs [Hash] <%= link_to_system_arguments_docs %>
    def initialize(**kwargs)
      @kwargs = kwargs
      @kwargs[:tag] = :div
    end

    def call
      render(Primer::BaseComponent.new(**@kwargs)) { content }
    end
  end
end
