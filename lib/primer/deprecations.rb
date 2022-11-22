# frozen_string_literal: true

module Primer
  # :nodoc:
  module Deprecations
    # If there is no alternative to suggest, set the value to nil
    DEPRECATED_COMPONENTS = {
      "Primer::LabelComponent" => "Primer::Beta::Label",
      "Primer::LinkComponent" => "Primer::Beta::Link",
      "Primer::Alpha::AutoComplete" => "Primer::Beta::AutoComplete",
      "Primer::Alpha::AutoComplete::Item" => "Primer::Beta::AutoComplete::Item",
      "Primer::BlankslateComponent" => "Primer::Beta::Blankslate",
      "Primer::BoxComponent" => "Primer::Box",
      "Primer::DropdownMenuComponent" => nil,
      "Primer::Dropdown" => "Primer::Alpha::Dropdown",
      "Primer::Dropdown::Menu" => "Primer::Alpha::Dropdown::Menu",
      "Primer::Dropdown::Menu::Item" => "Primer::Alpha::Dropdown::Menu::Item",
      "Primer::IconButton" => "Primer::Beta::IconButton",
      "Primer::Tooltip" => "Primer::Alpha::Tooltip",
      "Primer::PopoverComponent" => "Primer::Beta::Popover"
    }.freeze

    def self.deprecated?(name)
      DEPRECATED_COMPONENTS.key?(name)
    end

    def self.suggested_component(name)
      DEPRECATED_COMPONENTS[name]
    end

    def self.correctable?(name)
      !suggested_component(name).nil?
    end
  end
end
