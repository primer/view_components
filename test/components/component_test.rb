# frozen_string_literal: true

require "test_helper"

class PrimerComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  # Components with any arguments necessary to make them render
  COMPONENTS_WITH_ARGS = [
    [Primer::AutoCompleteComponent, { src: "Foo", id: "Bar" }, proc { |c| c.input(classes: "Baz") }],
    [Primer::AutoCompleteItemComponent, { value: "Foo" }],
    [Primer::AvatarComponent, { alt: "github", src: "https://github.com/github.png" }],
    [Primer::AvatarStackComponent, {}, lambda do |component|
      component.avatar(alt: "github", src: "https://github.com/github.png")
    end],
    [Primer::BaseComponent, { tag: :div }],
    [Primer::BlankslateComponent, { title: "Foo" }],
    [Primer::BorderBoxComponent, {}, proc { |component| component.header { "Foo" } }],
    [Primer::BoxComponent, {}],
    [Primer::BreadcrumbComponent, {}, proc { |component| component.item { "Foo" } }],
    [Primer::ButtonComponent, {}],
    [Primer::ButtonGroupComponent, {}, proc { |component| component.button { "Button" } }],
    [Primer::ButtonMarketingComponent, {}],
    [Primer::CounterComponent, { count: 1 }],
    [Primer::DetailsComponent, {}, lambda do |component|
      component.summary { "Foo" }
      component.body { "Bar" }
    end],
    [Primer::DropdownComponent, {}, lambda do |component|
      component.button { "Foo" }
      component.menu do |m|
        m.item { "Baz" }
      end
    end],
    [Primer::Dropdown::MenuComponent, {}],
    [Primer::DropdownMenuComponent, {}],
    [Primer::FlexComponent, {}],
    [Primer::FlashComponent, {}],
    [Primer::FlexItemComponent, { flex_auto: true }],
    [Primer::HeadingComponent, {}],
    [Primer::LabelComponent, { title: "Hello!" }],
    [Primer::LayoutComponent, {}],
    [Primer::LinkComponent, { href: "https://www.google.com" }],
    [Primer::MarkdownComponent, {}],
    [Primer::MenuComponent, {}, proc { |c| c.item(href: "#url") { "Item" } }],
    [Primer::Navigation::TabComponent, { id: "id" }],
    [Primer::OcticonComponent, { icon: "people" }],
    [Primer::PopoverComponent, {}, proc { |component| component.body { "Foo" } }],
    [Primer::ProgressBarComponent, {}, proc { |component| component.item }],
    [Primer::SpinnerComponent, {}],
    [Primer::StateComponent, { title: "Open" }],
    [Primer::SubheadComponent, { heading: "Foo" }, proc { |component| component.heading { "Foo" } }],
    [Primer::TabContainerComponent, {}, proc { "Foo" }],
    [Primer::TabNavComponent, { id: "id", label: "aria label" }, proc { |c| c.tab(title: "Foo", selected: true) }],
    [Primer::TextComponent, {}],
    [Primer::TruncateComponent, {}],
    [Primer::TimeAgoComponent, { time: Time.zone.now }],
    [Primer::TimelineItemComponent, {}, proc { |component| component.body { "Foo" } }],
    [Primer::TooltipComponent, { label: "More" }],
    [Primer::UnderlineNavComponent, { id: "id", label: "aria label" }, proc { |component| component.tab(selected: true) { "Foo" } }]
  ].freeze

  def test_registered_components
    ignored_components = ["Primer::Component"]

    primer_component_files_count = Dir["app/**/*component.rb"].count
    assert_equal primer_component_files_count, COMPONENTS_WITH_ARGS.length + ignored_components.count, "Primer component added. Please update this test with an entry for your new component <3"
  end

  def test_all_components_support_system_arguments
    COMPONENTS_WITH_ARGS.each do |component, args, proc|
      render_component(component, { my: 4 }.merge(args), proc)
      assert_selector(".my-4")
    end
  end

  def test_all_components_pass_through_classes
    COMPONENTS_WITH_ARGS.each do |component, args, proc|
      render_component(component, { classes: "foo" }.merge(args), proc)
      assert_selector(".foo")
    end
  end

  def test_all_components_support_inline_styles
    COMPONENTS_WITH_ARGS.each do |component, args, proc|
      render_component(component, { style: "width: 100%;" }.merge(args), proc)
      assert_selector("[style='width: 100%;']")
    end
  end

  def test_all_components_support_content_tag_arguments
    COMPONENTS_WITH_ARGS.each do |component, args, proc|
      render_component(component, { hidden: true }.merge(args), proc)
      assert_selector("[hidden]", visible: false)
    end
  end

  def test_all_components_support_data_tag_arguments
    COMPONENTS_WITH_ARGS.each do |component, args, proc|
      render_component(component, { "data-ga-click": "Foo,bar" }.merge(args), proc)
      assert_selector("[data-ga-click='Foo,bar']", visible: false)
    end
  end

  def test_all_slots_support_system_arguments
    COMPONENTS_WITH_ARGS.each do |component, args|
      next unless component.respond_to?(:slots) && component.slots.any?

      result = render_inline(component.new(**args)) do |c|
        component.slots.each do |slot_name, _slot_attributes|
          c.slot(
            slot_name,
            classes: "test-#{slot_name}",
            my: 1,
            hidden: true,
            style: "height: 100%;",
            "data-ga-click": "Foo,bar"
          ) { "foo" }
        end
      end

      component.slots.each do |slot_name, _attrs|
        assert_selector(
          ".test-#{slot_name}.my-1[hidden][data-ga-click='Foo,bar']",
          visible: false
        )

        assert_includes result.to_html, "height: 100%;"
      end
    end
  end

  def test_status_has_a_default
    assert_component_state(Primer::Component, :alpha)
  end

  def test_components_storybook_coverage
    components = Dir[Rails.root.join("../app/components/primer/**/*.rb")].map { |path| path.gsub(".rb", "").split("/").last }
    stories = Dir[Rails.root.join("../stories/primer/**/*.rb")].map { |path| path.gsub("_stories.rb", "").split("/").last }

    # TODO: Remove these exceptions as we add stories
    expected_missing_stories =
      [
        "component", # No story needed
        "view_components", # No story needed
        "slot", "component", # No story needed
        "flex_item_component",
        "dropdown_menu_component",
        "base_component",
        "flex_component"
      ]

    components_missing_stories = components - stories - expected_missing_stories

    message =
      if components_missing_stories.any?
        "It looks like you've added #{components_missing_stories.map(&:camelize).to_sentence} " \
        "without adding #{components_missing_stories.length > 1 ? 'corresponding stories' : 'a corresponding story'}"
      else
        ""
      end

    assert_empty(components_missing_stories, message)
  end

  def render_component(component, args, proc)
    render_inline(component.new(**args)) do |c|
      proc.call(c) if proc.present?
    end
  end
end
