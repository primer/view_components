# frozen_string_literal: true

module Primer
  module Alpha
    # @label UnderlinePanels
    class UnderlinePanelsPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param number_of_panels [Integer] number
      # @param align [Symbol] select [left, right]
      def playground(number_of_panels: 3, align: :left)
        render(Primer::Alpha::UnderlinePanels.new(label: "Test navigation", align: align)) do |component|
          Array.new(number_of_panels || 3) do |i|
            component.with_tab(selected: i.zero?, id: "tab-#{i + 1}") do |tab|
              tab.with_panel { "Panel #{i + 1}" }
              tab.with_text { "Tab #{i + 1}" }
            end
          end
        end
      end

      # @label Default options
      #
      # @snapshot
      # @param number_of_panels [Integer] number
      # @param align [Symbol] select [left, right]
      def default(number_of_panels: 3, align: :left)
        render(Primer::Alpha::UnderlinePanels.new(label: "Test navigation", align: align)) do |component|
          Array.new(number_of_panels || 3) do |i|
            component.with_tab(selected: i.zero?, id: "tab-#{i + 1}") do |tab|
              tab.with_panel { "Panel #{i + 1}" }
              tab.with_text { "Tab #{i + 1}" }
            end
          end
        end
      end

      # @label With Icons and Counters
      #
      # @snapshot
      # @param number_of_panels [Integer] number
      # @param align [Symbol] select [left, right]
      def with_icons_and_counters(number_of_panels: 3, align: :left)
        render(Primer::Alpha::UnderlinePanels.new(label: "Test navigation", align: align)) do |component|
          Array.new(number_of_panels || 3) do |i|
            component.with_tab(selected: i.zero?, id: "tab-#{i + 1}") do |tab|
              tab.with_panel { "Panel #{i + 1}" }
              tab.with_text { "Tab #{i + 1}" }
              tab.with_icon(icon: :star)
              tab.with_counter(count: (i + 1) * 5)
            end
          end
        end
      end

      # @label With Actions
      #
      # @snapshot
      # @param number_of_panels [Integer] number
      # @param align [Symbol] select [left, right]
      def with_actions(number_of_panels: 3, align: :right)
        render(Primer::Alpha::UnderlinePanels.new(label: "Test navigation", align: align)) do |component|
          Array.new(number_of_panels || 3) do |i|
            component.with_tab(selected: i.zero?, id: "tab-#{i + 1}") do |tab|
              tab.with_panel { "Panel #{i + 1}" }
              tab.with_text { "Tab #{i + 1}" }
            end
          end
          component.with_actions do
            "Actions Content"
          end
        end
      end
    end
  end
end
