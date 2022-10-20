# frozen_string_literal: true

require "components/test_helper"
require_relative "../../lib/primer/view_components/statuses"

class PrimerComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  # Components with any arguments necessary to make them render
  COMPONENTS_WITH_ARGS = [
    [Primer::Beta::IconButton, { icon: :star, "aria-label": "Star" }],
    [Primer::Beta::Button, {}],
    [Primer::Alpha::SegmentedControl, {
      full_width: false
    }, proc { |component|
      component.with_item(label: "Button", selected: true)
      component.with_item(label: "Button")
    }],
    [Primer::Alpha::SegmentedControl::Item, { label: "Button" }],
    [Primer::Alpha::Layout, {}, proc { |component|
      component.main(tag: :div) { "Foo" }
      component.sidebar(tag: :div) { "Bar" }
    }],
    [Primer::HellipButton, { "aria-label": "No action" }],
    [Primer::Alpha::TabPanels, { label: "label" }],
    [Primer::Alpha::TabNav, { label: "label" }],
    [Primer::Alpha::UnderlinePanels, { label: "Panel label" }],
    [Primer::Image, { src: "https://github.com/github.png", alt: "alt" }],
    [Primer::LocalTime, { datetime: DateTime.parse("2014-06-01T13:05:07Z") }],
    [Primer::ImageCrop, { src: "Foo" }],
    [Primer::IconButton, { icon: :star, "aria-label": "Label" }],
    [Primer::Alpha::ActionList, { aria: { label: "Action List" } }, lambda do |component|
      component.item(label: "Foo")
    end],
    [Primer::Alpha::AutoComplete, { label_text: "Fruits", src: "Foo", list_id: "Bar", input_id: "input-id", input_name: "input-name" }],
    [Primer::Alpha::AutoComplete::Item, { value: "Foo" }],
    [Primer::Beta::AutoComplete, { label_text: "Fruits", src: "Foo", list_id: "Bar", input_id: "input-id", input_name: "input-name" }],
    [Primer::Beta::AutoComplete::Item, { value: "Foo" }],
    [Primer::Beta::Avatar, { alt: "github", src: "https://github.com/github.png" }],
    [Primer::Beta::AvatarStack, {}, lambda do |component|
      component.avatar(alt: "github", src: "https://github.com/github.png")
    end],
    [Primer::Beta::BaseButton, {}],
    [Primer::BaseComponent, { tag: :div }],
    [Primer::Beta::Blankslate, {}, proc { |component|
      component.heading(tag: :h2) { "Foo" }
    }],
    [Primer::Beta::BorderBox, {}, proc { |component| component.header { "Foo" } }],
    [Primer::Beta::BorderBox::Header, {}],
    [Primer::BlankslateComponent, { title: "Foo" }],
    [Primer::Box, {}],
    [Primer::Beta::Breadcrumbs, {}, proc { |component| component.item(href: "/") { "Foo" } }],
    [Primer::ButtonComponent, {}, proc { "Button" }],
    [Primer::Beta::ButtonGroup, {}, proc { |component| component.button { "Button" } }],
    [Primer::Alpha::ButtonMarketing, {}],
    [Primer::ClipboardCopy, { "aria-label": "String that will be read to screenreaders", value: "String that will be copied" }],
    [Primer::ConditionalWrapper, { condition: true, tag: :div }],
    [Primer::Beta::CloseButton, {}],
    [Primer::Beta::Counter, { count: 1 }],
    [Primer::Beta::Details, {}, lambda do |component|
      component.summary { "Foo" }
      component.body { "Bar" }
    end],
    [Primer::Alpha::Dialog, { title: "Test" }, proc { |component|
      component.header { "Foo" }
      component.body { "Foo" }
      component.footer { "Foo" }
    }],
    [Primer::Alpha::Dialog::Header, { title: "Test", id: "test" }],
    [Primer::Alpha::Dialog::Body, {}],
    [Primer::Alpha::Dialog::Footer, {}],
    [Primer::Dropdown, {}, lambda do |component|
      component.button { "Foo" }
      component.menu do |m|
        m.item { "Baz" }
      end
    end],
    [Primer::Dropdown::Menu, {}],
    [Primer::DropdownMenuComponent, {}],
    [Primer::Beta::Flash, {}],
    [Primer::Beta::Heading, { tag: :h1 }],
    [Primer::Alpha::HiddenTextExpander, { "aria-label": "No action" }],
    [Primer::LabelComponent, {}],
    [Primer::LayoutComponent, {}],
    [Primer::LinkComponent, { href: "https://www.google.com" }],
    [Primer::Markdown, {}],
    [Primer::MenuComponent, {}, proc { |c| c.item(href: "#url") { "Item" } }],
    [Primer::Navigation::TabComponent, {}],
    [Primer::OcticonComponent, { icon: :people }],
    [Primer::PopoverComponent, {}, proc { |component| component.body { "Foo" } }],
    [Primer::ProgressBarComponent, {}, proc { |component| component.item }],
    [Primer::SpinnerComponent, {}],
    [Primer::StateComponent, { title: "Open" }],
    [Primer::SubheadComponent, { heading: "Foo" }, proc { |component| component.heading { "Foo" } }],
    [Primer::TabContainerComponent, {}, proc { "Foo" }],
    [Primer::Alpha::ToggleSwitch, {}],
    [Primer::Alpha::TextField, { name: :foo, label: "Foo" }],
    [Primer::Beta::Text, {}],
    [Primer::Truncate, {}],
    [Primer::Beta::Truncate, {}, proc { |component| component.item { "Foo" } }],
    [Primer::TimeAgoComponent, { time: Time.zone.now }],
    [Primer::TimelineItemComponent, {}, proc { |component| component.body { "Foo" } }],
    [Primer::Tooltip, { label: "More" }],
    [Primer::Alpha::UnderlineNav, { label: "aria label" }, proc { |component| component.tab(selected: true) { "Foo" } }],
    [Primer::Alpha::Tooltip, { type: :label, for_id: "some-button", text: "Foo" }],
    [Primer::Alpha::ActionList, { aria: { label: "Nav list" } }],
    [Primer::Alpha::NavList, { aria: { label: "Nav list" } }]
  ].freeze

  def test_registered_components
    ignored_components = [
      "Primer::Alpha::ActionList::Heading",
      "Primer::Alpha::ActionList::Item",
      "Primer::Alpha::ActionList::Separator",
      "Primer::Alpha::NavList::Section",
      "Primer::CounterComponent",
      "Primer::Component",
      "Primer::OcticonsSymbolComponent",
      "Primer::Content",
      "Primer::BoxComponent"
    ]

    primer_component_files_count = Dir["app/components/**/*.rb"].count { |p| p.exclude?("/experimental/") }
    assert_equal primer_component_files_count, COMPONENTS_WITH_ARGS.length + ignored_components.count, "Primer component added. Please update this test with an entry for your new component <3"
  end

  def test_all_components_support_system_arguments
    default_args = { my: 4 }
    COMPONENTS_WITH_ARGS.each do |component, args, proc|
      render_component(component, default_args.merge(args), proc)
      assert_selector(".my-4", visible: :all, message: "#{component.name} does not support system arguments")
    end
  end

  def test_all_components_pass_through_classes
    default_args = { classes: "foo" }
    COMPONENTS_WITH_ARGS.each do |component, args, proc|
      render_component(component, default_args.merge(args), proc)
      assert_selector(".foo", visible: :all, message: "#{component.name} does not pass through classes")
    end
  end

  def test_all_components_support_inline_styles
    default_args = { style: "width: 100%;" }
    COMPONENTS_WITH_ARGS.each do |component, args, proc|
      render_component(component, default_args.merge(args), proc)
      assert_selector("[style='width: 100%;']", visible: :all, message: "#{component.name} does not support inline styles")
    end
  end

  def test_all_components_support_content_tag_arguments
    default_args = { hidden: true }
    COMPONENTS_WITH_ARGS.each do |component, args, proc|
      render_component(component, default_args.merge(args), proc)
      assert_selector("[hidden]", visible: false, message: "#{component.name} does not support content tag arguments")
    end
  end

  def test_all_components_support_data_tag_arguments
    default_args = { "data-ga-click": "Foo,bar" }
    COMPONENTS_WITH_ARGS.each do |component, args, proc|
      render_component(component, default_args.merge(args), proc)
      assert_selector("[data-ga-click='Foo,bar']", visible: false, message: "#{component.name} does not support data arguments")
    end
  end

  def test_status_has_a_default
    assert_component_state(Primer::Component, :alpha)
  end

  def render_component(component, args, proc)
    render_inline(component.new(**args)) do |c|
      proc.call(c) if proc.present?
    end
  end

  def test_deprecated_components_by_status_match_list
    deprecated_by_status = Primer::ViewComponents::STATUSES.select { |_, value| value == "deprecated" }.keys.sort
    deprecated_by_list = ::Primer::Deprecations::DEPRECATED_COMPONENTS.keys.sort

    assert_empty(deprecated_by_status - deprecated_by_list, "Please make sure that components are officially deprecated by setting the `status :deprecated` within the component file.\nMake sure to provide an alternative component for each deprecated component in Primer::Deprecations::DEPRECATED_COMPONENTS (lib/primer/deprecations.rb). If there is no alternative to suggest, set the value to nil.")
  end
end
