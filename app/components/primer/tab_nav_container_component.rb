# frozen_string_literal: true

module Primer
  class TabNavContainerComponent < Primer::Component
    include ViewComponent::SlotableV2

    renders_one :nav, ->(**system_arguments) { Primer::TabNavComponent.new(with_panel: true, **system_arguments) }

    def initialize(**system_arguments)
      @system_arguments = system_arguments
    end

    def render?
      nav.present?
    end
  end
end
