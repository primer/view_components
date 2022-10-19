# frozen_string_literal: true

module Primer
  # @label Dropdown
  class DropdownPreview < ViewComponent::Preview
    # @label Playground
    #
    # @param with_caret [Boolean] toggle
    # @param overlay [Symbol] select [none, default, dark]
    def playground(overlay: :default, with_caret: false)
      render(Primer::Dropdown.new(overlay: overlay, with_caret: with_caret)) do |c|
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

    # @label Default Options
    #
    # @param with_caret [Boolean] toggle
    # @param overlay [Symbol] select [none, default, dark]
    def default(overlay: :default, with_caret: false)
      render(Primer::Dropdown.new(overlay: overlay, with_caret: with_caret)) do |c|
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

    # @label Menu Options
    #
    # @param as [Symbol] select [list, default]
    # @param direction [Symbol] select [se, sw, w, e, ne, s]
    # @param scheme [Symbol] select [default, dark]
    def menu(as: :default, direction: :se, scheme: :default)
      render(Primer::Dropdown::Menu.new(as: as, direction: direction, scheme: scheme, header: "Header")) do |m|
        m.with_item { "Item 1" }
        m.with_item { "Item 2" }
        m.with_item(divider: true)
        m.with_item { "Item 3" }
        m.with_item { "Item 4" }
      end
    end
  end
end
