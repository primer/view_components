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
      # @param number_of_panels [Integer] number
      # @param align [Symbol] select [left, right]
      def default(number_of_panels: 3, align: :left)
        render(Primer::Alpha::UnderlinePanels.new(label: "Test navigation", align: align)) do |component|
          Array.new(number_of_panels&.to_i || 3) do |i|
            component.with_tab(selected: i.zero?, id: "tab-#{i + 1}") do |tab|
              tab.with_panel { "Panel #{i + 1}" }
              tab.with_text { "Tab #{i + 1}" }
            end
          end
        end
      end
    end
  end
end
