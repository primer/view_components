# frozen_string_literal: true

require "test_helper"

class PrimerComponentTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_primer_components_provide_a_consistent_interface
    # Components with any arguments necessary to make them render
    components_with_args = [
      [Primer::AvatarComponent, { alt: "github", src: "https://github.com/github.png" }],
      [Primer::BaseComponent, { tag: :div }],
      [Primer::BlankslateComponent, { title: "Foo" }],
      [Primer::BorderBoxComponent, {}, proc { |component| component.slot(:header) { "Foo" } }],
      [Primer::BoxComponent, {}],
      [Primer::BreadcrumbComponent, {}, proc { |component| component.slot(:item) { "Foo" } }],
      [Primer::ButtonComponent, {}],
      [Primer::CounterComponent, { count: 1 }],
      [Primer::DetailsComponent, {}, lambda do |component|
        component.slot(:summary) { "Foo" }
        component.slot(:body) { "Bar" }
      end],
      [Primer::DropdownMenuComponent, {}],
      [Primer::FlexComponent, {}],
      [Primer::FlexItemComponent, { flex_auto: true }],
      [Primer::HeadingComponent, {}],
      [Primer::LabelComponent, { title: "Hello!" }],
      [Primer::LayoutComponent, {}],
      [Primer::LinkComponent, { href: "https://www.google.com" }],
      [Primer::PopoverComponent, {}, proc { |component| component.slot(:body) }],
      [Primer::ProgressBarComponent, {}, proc { |component| component.slot(:item) }],
      [Primer::StateComponent, { title: "Open" }],
      [Primer::SubheadComponent, { heading: "Foo" }, proc { |component| component.slot(:heading) { "Foo" } }],
      [Primer::TextComponent, {}],
      [Primer::TimelineItemComponent, {}, proc { |component| component.slot(:body) { "Foo" } }],
      [Primer::UnderlineNavComponent, {}],
    ]

    ignored_components = ["Primer::Component"]

    primer_component_files_count = Dir["app/**/*component.rb"].count
    assert_equal primer_component_files_count, components_with_args.length + ignored_components.count, "Primer component added. Please update this test with an entry for your new component <3"

    components_with_args.each do |component, args, proc|
      # component renders hash arguments
      render_component(component, { my: 4 }.merge(args), proc)
      assert_selector(".my-4")

      # component passes through class_names
      render_component(component, { classes: "foo" }.merge(args), proc)
      assert_selector(".foo")

      # component supports basic content_tag arguments
      render_component(component, { hidden: true }.merge(args), proc)
      assert_selector("[hidden]", visible: false)

      render_component(component, { "data-ga-click": "Foo,bar" }.merge(args), proc)
      assert_selector("[data-ga-click='Foo,bar']", visible: false)

      # Ensure all slots accept Primer kwargs
      if component.slots.any?
        render_inline(component.new(**args)) do |c|
          component.slots.each do |slot_name, slot_attributes|
            c.slot(
              slot_name,
              classes: "test-#{slot_name}",
              my: 1,
              hidden: true,
              "data-ga-click": "Foo,bar"
            ) { "foo" }
          end
        end

        component.slots.each do |slot_name, _attrs|
          assert_selector(".test-#{slot_name}.my-1[hidden][data-ga-click='Foo,bar']", visible: false)
        end
      end
    end
  end

  def render_component(component, args, proc)
    render_inline(component.new(**args)) do |c|
      proc.call(c) if proc.present?
    end
  end
end
