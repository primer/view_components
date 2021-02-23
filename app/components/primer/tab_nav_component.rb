# frozen_string_literal: true

module Primer
  class TabNavComponent < Primer::Component
    include ViewComponent::SlotableV2

    renders_many :tabs, -> (**system_arguments) do
      return TabComponent.new(**system_arguments) unless @with_panel

      TabComponent.new(tag: :button, type: :button, **system_arguments)
    end

    def initialize(aria_label: nil, with_panel: false, **system_arguments)
      @aria_label = aria_label
      @with_panel = with_panel
      @system_arguments = system_arguments
      @system_arguments[:tag] ||= :div

      @system_arguments[:classes] = class_names(
        "tabnav",
        system_arguments[:classes],
      )
    end

    def render?
      tabs.any?
    end

    class TabComponent < Primer::Component
      def initialize(title:, selected: false, **system_arguments)
        @title = title
        @selected = selected
        @system_arguments = system_arguments
        @system_arguments[:tag] ||= :a
        @system_arguments[:role] = :tab

        if selected
          if @system_arguments[:tag] == :a
            @system_arguments[:"aria-current"] = :page
          else
            @system_arguments[:"aria-selected"] = true
          end
        end

        @system_arguments[:classes] = class_names(
          "tabnav-tab",
          system_arguments[:classes],
        )
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments)) { @title }
      end

      def panel
        content
      end

      def hidden?
        !@selected
      end
    end
  end
end
