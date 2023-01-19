# frozen_string_literal: true

module Primer
  module Alpha
    # @label TabNav
    class TabNavPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param number_of_tabs [Integer] number
      # @param with_icons [Boolean] toggle
      # @param with_counters [Boolean] toggle
      def playground(number_of_tabs: 3, with_icons: false, with_counters: false)
        render(Primer::Alpha::TabNav.new(label: "label")) do |component|
          Array.new(number_of_tabs || 3) do |i|
            component.with_tab(selected: i.zero?, href: "##{i + 1}") do |tab|
              tab.with_icon(icon: :star) if with_icons
              tab.with_text { "Tab #{i + 1}" }
              tab.with_counter(count: 10) if with_counters
            end
          end
        end
      end

      # @label Default
      def default
        render(Primer::Alpha::TabNav.new(label: "Default")) do |component|
          component.with_tab(selected: true, href: "#") { "Tab 1" }
          component.with_tab(href: "#") { "Tab 2" }
          component.with_tab(href: "#") { "Tab 3" }
        end
      end

      # @label With icons and counters
      def with_icons_and_counters
        render(Primer::Alpha::TabNav.new(label: "With icons and counters")) do |component|
          component.with_tab(href: "#1", selected: true) do |tab|
            tab.with_icon(icon: :star)
            tab.with_text { "Stars" }
            tab.with_counter(count: 10)
          end
          component.with_tab(href: "#2") do |tab|
            tab.with_icon(icon: :heart)
            tab.with_text { "Sponsors" }
            tab.with_counter(count: 14)
          end
          component.with_tab(href: "#3") do |tab|
            tab.with_icon(icon: :bookmark)
            tab.with_text { "Bookmarks" }
            tab.with_counter(count: 7)
          end
        end
      end
    end
  end
end
