# frozen_string_literal: true

module Primer
  # :nodoc:
  module Deprecations
    # If there is no alternative to suggest, set the value to nil
    DEPRECATED_COMPONENTS = {
      "Primer::Alpha::AutoComplete" => "Primer::Beta::AutoComplete",
      "Primer::Alpha::AutoComplete::Item" => "Primer::Beta::AutoComplete::Item",
      "Primer::BlankslateComponent" => "Primer::Beta::Blankslate",
      "Primer::BoxComponent" => "Primer::Box",
      "Primer::CounterComponent" => "Primer::Beta::Counter",
      "Primer::DropdownMenuComponent" => nil,
      "Primer::IconButton" => "Primer::Beta::IconButton",
      "Primer::Tooltip" => "Primer::Alpha::Tooltip"
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
