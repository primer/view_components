# frozen_string_literal: true

module Primer
  module Alpha
    # @label ResponsiveComponent
    class ResponsiveComponentPreview < ViewComponent::Preview
      # @hidden
      def hash_recursive
        Hash.new do |hash, key|
          hash[key] = hash_recursive
        end
      end

      # @label Values validation playground
      #
      # @param uuid text
      # @param id number
      # @param spacing select [~, xs, s, m, l, xl, xxl]
      # @param spacing_v_narrow select [~, xs, s, m, l, xl, xxl]
      # @param spacing_v_regular select [~, xs, s, m, l, xl, xxl]
      # @param spacing_v_wide select [~, xs, s, m, l, xl, xxl]
      # @param placement_viewport select [~, center, top, bottom, full]
      # @param placement_viewport_v_narrow select [~, center, top, bottom, full]
      # @param placement_viewport_v_regular select [~, center, top, bottom, full]
      # @param placement_viewport_v_wide select [~, center, top, bottom, full]
      # @param placement_container select [~, top, right, bottom, left]
      def argument_values_defaults(
        uuid: "",
        id: 0,
        spacing: nil,
        spacing_v_narrow: nil,
        spacing_v_regular: nil,
        spacing_v_wide: nil,
        placement_viewport: nil,
        placement_viewport_v_narrow: nil,
        placement_viewport_v_regular: nil,
        placement_viewport_v_wide: nil,
        placement_container: nil
      )
        values = hash_recursive
        values[:uuid] = uuid unless uuid.empty?
        values[:id] = id
        values[:spacing] = spacing.to_sym unless spacing.nil?
        values[:v_narrow][:spacing] = spacing_v_narrow.to_sym unless spacing_v_narrow.nil?
        values[:v_regular][:spacing] = spacing_v_regular.to_sym unless spacing_v_regular.nil?
        values[:v_wide][:spacing] = spacing_v_wide.to_sym unless spacing_v_wide.nil?
        values[:placement][:viewport] = placement_viewport.to_sym unless placement_viewport.nil?
        values[:v_narrow][:placement][:viewport] = placement_viewport_v_narrow.to_sym unless placement_viewport_v_narrow.nil?
        values[:v_regular][:placement][:viewport] = placement_viewport_v_regular.to_sym unless placement_viewport_v_regular.nil?
        values[:v_wide][:placement][:viewport] = placement_viewport_v_wide.to_sym unless placement_viewport_v_wide.nil?
        values[:placement][:container] = placement_container.to_sym unless placement_container.nil?

        cloned_values = values.deep_dup
        component = DummyResponsiveComponent.new(argument_values: cloned_values)
        component.normalize_values!

        panels = [
          { title: "Values", output: values.pretty_inspect },
          { title: "Normalized", output: component.argument_values.pretty_inspect },
          { title: "Component", output: component.pretty_inspect }
        ]

        render_with_template(
          locals: { panels: panels },
          template: "primer/responsive/responsive_preview_output"
        )
      end

      # @label Normalize values
      def normalize_argument_values
        values = {
          uuid: "unique-hash",
          id: "test",
          spacing: :not_defined,
          placement: {
            container: :middle
          }
        }

        cloned_values = values.deep_dup
        component = Alpha::DummyResponsiveComponent.new(argument_values: cloned_values)
        with_default_values = component.normalize_values(argument_values: cloned_values, fallback_to_default: true)

        panels = [
          { title: "Values", output: values.pretty_inspect },
          { title: "Values with default", output: with_default_values.pretty_inspect },
          { title: "Component", output: component.pretty_inspect }
        ]

        render_with_template(
          locals: { panels: panels },
          template: "primer/responsive/responsive_preview_output"
        )
      end

      # @label List defaults from definitions
      def argument_definition
        instance = Alpha::ChildDummyResponsiveComponent.new

        panels = [
          { title: "Arguments", output: instance.args.pretty_inspect }
        ]

        render_with_template(
          locals: { panels: panels },
          template: "primer/responsive/responsive_preview_output"
        )
      end

      # @!group Html Attributes
      # @label html attributes validation
      def invalid_html_attributes
        html_attributes = {
          class: %w[class-a class-b class-c],
          autofocus: true,
          type: "datetime"
        }

        begin
          Alpha::ChildDummyResponsiveComponent.new(
            argument_values: {},
            html_attributes: html_attributes
          )
        rescue Primer::Responsive::HtmlAttributesHelper::InvalidHtmlAttributeError => e
          error_message = "#{e.message}*In production, html attributes are going to be sanitized, but no exception is thrown."
        end

        panels = [
          { title: "Attributes", output: html_attributes.pretty_inspect },
          { title: "Error", output: error_message }
        ]

        render_with_template(
          locals: { panels: panels },
          template: "primer/responsive/responsive_preview_output"
        )
      end

      # @label Rendering html attributes
      def html_attributes_render
        component = Alpha::ChildDummyResponsiveComponent.new(
          argument_values: {},
          html_attributes: {
            class: %w[class-a class-b class-c],
            data: {
              "entity-id": 1234,
              readonly: :readonly,
              disabled: true,
              "entity-title": "Clean-up taks list"
            },
            autofocus: true
          }
        )

        render_with_template(
          locals: { component: component, ViewComponent: ViewComponent },
          template: "primer/alpha/responsive_component_attribute_render"
        )
      end
      # @!endgroup

      # @label argument definitions
      def argument_definitions
        begin
          component = Alpha::DummyResponsiveComponent.new
        rescue StandardError => e
          error_message = e.message
        end
        render_with_template(
          locals: {
            args: nil, # Alpha::DummyResponsiveComponent::args_DEFINITION_FOR_TESTS.pretty_inspect,
            component: component.pretty_inspect,
            error_message: error_message
          },
          template: "primer/alpha/responsive_component_preview"
        )
      end

      # @label argument definitions inheritance
      def inherited_argument_definitions
        component = Alpha::ChildDummyResponsiveComponent.new(
          html_attributes: {
            id: "unique-id",
            for: "some-id",
            autocomplete: "autocomplete"
          }
        )

        render_with_template(
          locals: {
            args: nil,
            component: component.pretty_inspect,
            error_message: nil
          },
          template: "primer/alpha/responsive_component_preview"
        )
      end
    end

    # === COMPONENT CLASS TESTS ===
    # class for testing responsive component class methods
    class DummyResponsiveComponent < ::Primer::Alpha::ResponsiveComponent
      attr_reader :args

      arguments_definition(
        uuid: arg(
          type: String
        ),
        id: arg(
          type: Integer,
          default: 0
        ),
        spacing: arg(
          responsive: :yes,
          allowed_values: [:s, :m, :l],
          v_narrow: { default: :s },
          v_regular: {
            additional_allowed_values: [:xs, :xl],
            default: :l
          },
          v_wide: {
            additional_allowed_values: [:xl, :xxl],
            default: :xl
          }
        ),
        placement: {
          viewport: arg(
            responsive: :transitional,
            allowed_values: [:center, :top, :bottom, :full],
            default: :top,
            v_narrow: { default: :full },
            v_regular: { default: :top }
          ),
          container: arg(
            allowed_values: [:top, :right, :bottom, :left],
            default: :bottom
          )
        },
        double: {
          namespace: {
            test_prop: arg(
              responsive: :yes,
              allowed_values: [:test_a, :test_b, :test_c],
              v_narrow: { default: :test_a },
              v_regular: { default: :test_a },
              v_wide: { default: :test_c }
            )
          }
        }
      )

      def initialize(argument_values: {}, html_attributes: {})
        super
        @args = DummyResponsiveComponent.arguments
      end

      def should_raise_error?
        true
      end
    end

    # dummy class to test inherited arguments
    class ChildDummyResponsiveComponent < ::Primer::Alpha::DummyResponsiveComponent
      attr_reader :args

      additional_allowed_html_attributes :for, :autocomplete

      add_arguments_definition(
        id: arg(
          type: String,
          default: "empty id"
        ),
        name: arg(
          type: String,
          responsive: :yes,
          default: "no name"
        )
      )

      style_class_map(
        general: {
          id: {
            "0": "ChildComponent-not-persisted"
          }
        },
        responsive: {
          name: {
            "no mame": "ChildComponent-nameless"
          },
          spacing: {
            s: "ChildComponent-spacing-Small",
            m: "ChildComponent-spacing-Medium",
            l: "ChildComponent-spacing-Large"
          }
        },
        with_responsive: {
          placement: {
            viewport: {
              center: "ChildComponent-Viewport-Center",
              top: "ChildComponent-Viewport-Top",
              bottom: "ChildComponent-Viewport-Bottom",
              full: "ChildComponent-Viewport-Full"
            }
          }
        }
      )

      def initialize(argument_values: {}, html_attributes: {})
        super
        @args = ChildDummyResponsiveComponent.arguments
      end
    end

    # class for responsive default tests
    class DefaultValuesResponsiveComponent < ::Primer::Alpha::ResponsiveComponent
      arguments_definition(
        responsive_a: arg(
          responsive: :yes,
          allowed_values: [:a, :b, :c],
          default: :b
        ),
        responsive_opt_a: arg(
          responsive: :transitional,
          allowed_values: [:a, :b, :c],
          default: :b
        ),
        responsive_b: arg(
          responsive: :yes,
          allowed_values: [:a, :b, :c],
          v_narrow: { default: :a },
          v_regular: { default: :b },
          v_wide: { default: :c }
        ),
        nested: {
          responsive_c: arg(
            responsive: :yes,
            allowed_values: [:a, :b],
            v_narrow: {
              additional_allowed_values: [:na, :nb],
              default: :na
            },
            v_regular: {
              additional_allowed_values: [:rd, :re],
              default: :a
            },
            v_wide: {
              additional_allowed_values: [:wc, :wd],
              default: :wd
            }
          )
        }
      )
    end
  end
end
