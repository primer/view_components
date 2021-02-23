# frozen_string_literal: true

module Primer
  class TabContainerComponent < Primer::Component

    def initialize(**system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = "tab-container"
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { content }
    end

    def render?
      content.present?
    end
  end
end
