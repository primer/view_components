# frozen_string_literal: true

module Primer
  module Alpha
    # @label TabPanels
    class TabPanelsPreview < ViewComponent::Preview
      # @label Default options
      #
      # @param number_of_panels [Integer] number
      # @param align [Symbol] select [left, right]
      def default(number_of_panels: 3, align: :left)
        render(Primer::Alpha::TabPanels.new(label: "label", align: align)) do |c|
          Array.new(number_of_panels || 3) do |i|
            c.tab(selected: i.zero?, id: "tab-#{i + 1}") do |t|
              t.panel { "Panel #{i + 1}" }
              t.text { "Tab #{i + 1}" }
            end
          end
        end
      end
    end
  end
end
