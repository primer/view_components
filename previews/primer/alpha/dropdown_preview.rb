# frozen_string_literal: true

module Primer
  module Alpha
    # @label Dropdown
    class DropdownPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param with_caret [Boolean] toggle
      # @param overlay [Symbol] select [none, default, dark]
      def playground(overlay: :default, with_caret: false)
        render(Primer::Alpha::Dropdown.new(overlay: overlay, with_caret: with_caret)) do |c|
          c.with_button { "Dropdown" }

          c.with_menu(header: "Header") do |m|
            m.with_item { "Item 1" }
            m.with_item { "Item 2" }
            m.with_item(divider: true)
            m.with_item { "Item 3" }
            m.with_item { "Item 4" }
          end
        end
      end

      # @label Default
      #
      def default
        render(Primer::Alpha::Dropdown.new) do |c|
          c.with_button { "Dropdown" }
          c.with_menu do |m|
            m.with_item { "Item 1" }
            m.with_item { "Item 2" }
            m.with_item { "Item 3" }
          end
        end
      end

      # @label Menu
      #
      # @param as [Symbol] select [list, default]
      # @param direction [Symbol] select [se, sw, w, e, ne, s]
      # @param scheme [Symbol] select [default, dark]
      def menu(as: :default, direction: :se, scheme: :default)
        render(Primer::Alpha::Dropdown::Menu.new(as: as, direction: direction, scheme: scheme, header: "Header")) do |m|
          m.with_item { "Item 1" }
          m.with_item { "Item 2" }
          m.with_item(divider: true)
          m.with_item { "Item 3" }
          m.with_item { "Item 4" }
        end
      end

      # @!group Direction
      #
      # @label Direction e
      def direction_e
        render(Primer::Alpha::Dropdown.new(display: :inline_block)) do |c|
          c.with_button { "Dropdown" }
          c.with_menu(direction: :e) do |m|
            m.with_item { "Item 1" }
            m.with_item { "Item 2" }
            m.with_item { "Item 3" }
          end
        end
      end

      # @label Direction ne
      def direction_ne
        render(Primer::Alpha::Dropdown.new(display: :inline_block)) do |c|
          c.with_button { "Dropdown" }
          c.with_menu(direction: :ne) do |m|
            m.with_item { "Item 1" }
            m.with_item { "Item 2" }
            m.with_item { "Item 3" }
          end
        end
      end

      # @label Direction s
      def direction_s
        render(Primer::Alpha::Dropdown.new(display: :inline_block)) do |c|
          c.with_button { "Dropdown" }
          c.with_menu(direction: :s) do |m|
            m.with_item { "Item 1" }
            m.with_item { "Item 2" }
            m.with_item { "Item 3" }
          end
        end
      end

      # @label Direction se
      def direction_se
        render(Primer::Alpha::Dropdown.new(display: :inline_block)) do |c|
          c.with_button { "Dropdown" }
          c.with_menu(direction: :se) do |m|
            m.with_item { "Item 1" }
            m.with_item { "Item 2" }
            m.with_item { "Item 3" }
          end
        end
      end

      # @label Direction sw
      def direction_sw
        render(Primer::Alpha::Dropdown.new(display: :inline_block)) do |c|
          c.with_button { "Dropdown" }
          c.with_menu(direction: :sw) do |m|
            m.with_item { "Item 1" }
            m.with_item { "Item 2" }
            m.with_item { "Item 3" }
          end
        end
      end

      # @label Direction w
      def direction_w
        render(Primer::Alpha::Dropdown.new(display: :inline_block)) do |c|
          c.with_button { "Dropdown" }
          c.with_menu(direction: :w) do |m|
            m.with_item { "Item 1" }
            m.with_item { "Item 2" }
            m.with_item { "Item 3" }
          end
        end
      end
      #
      # @!endgroup

      # @!group Options
      #
      # @label With caret
      def options_with_caret
        render(Primer::Alpha::Dropdown.new(with_caret: true)) do |c|
          c.with_button { "Dropdown" }
          c.with_menu do |m|
            m.with_item { "Item 1" }
            m.with_item { "Item 2" }
            m.with_item { "Item 3" }
          end
        end
      end

      # @label With header
      def options_with_header
        render(Primer::Alpha::Dropdown.new) do |c|
          c.with_button { "Dropdown" }
          c.with_menu(header: "Header") do |m|
            m.with_item { "Item 1" }
            m.with_item { "Item 2" }
            m.with_item { "Item 3" }
          end
        end
      end

      # @label With dividers
      def options_with_dividers
        render(Primer::Alpha::Dropdown.new) do |c|
          c.with_button { "Dropdown" }
          c.with_menu do |m|
            m.with_item { "Item 1" }
            m.with_item { "Item 2" }
            m.with_item(divider: true)
            m.with_item { "Item 3" }
            m.with_item { "Item 4" }
            m.with_item(divider: true)
            m.with_item { "Item 5" }
          end
        end
      end

      # @label As list
      def options_as_list
        render(Primer::Alpha::Dropdown.new) do |c|
          c.with_button { "Dropdown" }
          c.with_menu(as: :list) do |m|
            m.with_item { "Item 1" }
            m.with_item { "Item 2" }
            m.with_item { "Item 3" }
          end
        end
      end

      # @label Overlay none
      def options_overlay_none
        render(Primer::Alpha::Dropdown.new(overlay: :none)) do |c|
          c.with_button { "Dropdown" }
          c.with_menu do |m|
            m.with_item { "Item 1" }
            m.with_item { "Item 2" }
            m.with_item { "Item 3" }
          end
        end
      end

      # @label Overlay dark
      def options_overlay_dark
        render(Primer::Alpha::Dropdown.new(overlay: :dark)) do |c|
          c.with_button { "Dropdown" }
          c.with_menu do |m|
            m.with_item { "Item 1" }
            m.with_item { "Item 2" }
            m.with_item { "Item 3" }
          end
        end
      end
      #
      # @!endgroup
    end
  end
end
