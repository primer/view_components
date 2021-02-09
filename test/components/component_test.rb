# frozen_string_literal: true

require "test_helper"

class PrimerComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  # Components with any arguments necessary to make them render
  COMPONENTS_WITH_ARGS = [
    [Primer::AvatarComponent, { alt: "github", src: "https://github.com/github.png" }],
    [Primer::BaseComponent, { tag: :div }],
    [Primer::BlankslateComponent, { title: "Foo" }],
    [Primer::BorderBoxComponent, {}, proc { |component| component.slot(:header) { "Foo" } }],
    [Primer::BoxComponent, {}],
    [Primer::BreadcrumbComponent, {}, proc { |component| component.slot(:item) { "Foo" } }],
    [Primer::ButtonComponent, {}],
    [Primer::ButtonGroupComponent, {}, proc { |component| component.button { "Button" } }],
    [Primer::ButtonMarketingComponent, {}],
    [Primer::CounterComponent, { count: 1 }],
    [Primer::DetailsComponent, {}, lambda do |component|
      component.slot(:summary) { "Foo" }
      component.slot(:body) { "Bar" }
    end],
    [Primer::DropdownMenuComponent, {}],
    [Primer::FlexComponent, {}],
    [Primer::FlashComponent, {}],
    [Primer::FlexItemComponent, { flex_auto: true }],
    [Primer::HeadingComponent, {}],
    [Primer::LabelComponent, { title: "Hello!" }],
    [Primer::LayoutComponent, {}],
    [Primer::LinkComponent, { href: "https://www.google.com" }],
    [Primer::OcticonComponent, { icon: "people" }],
    [Primer::PopoverComponent, {}, proc { |component| component.slot(:body) }],
    [Primer::ProgressBarComponent, {}, proc { |component| component.slot(:item) }],
    [Primer::SpinnerComponent, {}],
    [Primer::StateComponent, { title: "Open" }],
    [Primer::SubheadComponent, { heading: "Foo" }, proc { |component| component.slot(:heading) { "Foo" } }],
    [Primer::TextComponent, {}],
    [Primer::TruncateComponent, {}],
    [Primer::TimelineItemComponent, {}, proc { |component| component.slot(:body) { "Foo" } }],
    [Primer::TooltipComponent, { label: "More" }],
    [Primer::UnderlineNavComponent, {}]
  ].freeze

  def test_registered_components
    ignored_components = ["Primer::Component"]

    primer_component_files_count = Dir["app/**/*component.rb"].count
    assert_equal primer_component_files_count, COMPONENTS_WITH_ARGS.length + ignored_components.count, "Primer component added. Please update this test with an entry for your new component <3"
  end

  def test_primer_components_provide_a_consistent_interface
    COMPONENTS_WITH_ARGS.each do |component, args, proc|
      # component renders hash arguments
      render_component(component, { my: 4 }.merge(args), proc)
      assert_selector(".my-4")

      # component passes through class_names
      render_component(component, { classes: "foo" }.merge(args), proc)
      assert_selector(".foo")

      # component supports inline styles
      render_component(component, { style: "width: 100%;" }.merge(args), proc)
      assert_selector("[style='width: 100%;']")

      # component supports basic content_tag arguments
      render_component(component, { hidden: true }.merge(args), proc)
      assert_selector("[hidden]", visible: false)

      render_component(component, { "data-ga-click": "Foo,bar" }.merge(args), proc)
      assert_selector("[data-ga-click='Foo,bar']", visible: false)

      # Ensure all slots accept Primer system_arguments
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
    assert_equal Primer::Component.status, Primer::Component::STATUSES[:alpha]
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
