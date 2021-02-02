# frozen_string_literal: true

module Primer
  # :nodoc
  class HeadingComponent < Primer::Component
    def initialize(**system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] ||= :h1
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
