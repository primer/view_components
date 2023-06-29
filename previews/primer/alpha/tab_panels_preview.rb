# frozen_string_literal: true

module Primer
  module Alpha
    # @label TabPanels
    class TabPanelsPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param number_of_panels [Integer] number
      # @param align [Symbol] select [left, right]
      def playground(number_of_panels: 3, align: :left)
        render(Primer::Alpha::TabPanels.new(label: "label", align: align)) do |component|
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
      # @snapshot
      def default(number_of_panels: 3, align: :left)
        render(Primer::Alpha::TabPanels.new(label: "label", align: align)) do |component|
          Array.new(number_of_panels || 3) do |i|
            component.with_tab(selected: i.zero?, id: "tab-#{i + 1}") do |tab|
              tab.with_panel { "Panel #{i + 1}" }
              tab.with_text { "Tab #{i + 1}" }
            end
          end
        end
      end

      # @param align [Symbol] select [left, right]
      def with_extra(align: :right)
        render_with_template(locals: { align: align })
      end
    end
  end
end
