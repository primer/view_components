module Primer
  module Deprecations
    DEPRECATIONS = {
      "Primer::Alpha::AutoComplete" => "Primer::Beta::AutoComplete",
      "Primer::Alpha::AutoComplete::Item" => "Primer::Beta::AutoComplete::Item",
      "Primer::BaseButton" => "Primer::Beta::BaseButton",
      "Primer::BlankslateComponent" => "Primer::Beta::Blankslate",
      "Primer::BoxComponent" => "Primer::Box",
      "Primer::ButtonGroup" => "Primer::Beta::ButtonGroup",
      "Primer::CloseButton" => "Primer::Beta::CloseButton",
      "Primer::CounterComponent" => "Primer::Beta::Counter",
      "Primer::DetailsComponent" => "Primer::Beta::Details",
      "Primer::DropdownMenuComponent" => nil,
      "Primer::FlexComponent" => nil,
      "Primer::FlexItemComponent" => nil,
      "Primer::HeadingComponent" => "Primer::Beta::Heading",
      "Primer::HiddenTextExpander" => "Primer::Alpha::HiddenTextExpander",
      "Primer::TestComponent" => "Primer::Beta::Test",
      "Primer::Tooltip" => "Primer::Alpha::Tooltip"
    }.freeze

    def self.deprecated?(name)
      DEPRECATIONS.key?(name)
    end

    def self.suggested_component(name)
      DEPRECATIONS[name]
    end

    def self.correctable?(name)
      !suggested_component(name).nil?
    end
  end
end
