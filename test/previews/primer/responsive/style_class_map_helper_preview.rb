# frozen_string_literal: true

module Primer
  module Responsive
    # @label StyleClassMapHelper
    class StyleClassMapHelperPreview < ViewComponent::Preview
      include Primer::Responsive::StyleClassMapHelper

      MAIN_TEMPLATE = "primer/responsive/responsive_preview_output"

      CLASS_MAP = {
        prop_a: {
          value_a: "Component-a-valueA",
          value_b: "Component-a-valueB",
          value_c: "Component-a-valueC"
        },
        prop_b: "Component-b",
        prop_c: {
          "1" => "Component-c-1",
          "2" => "Component-c-2"
        },
        deep_prop: {
          dp_a: {
            s: "Component-deep-a-Small",
            m: "Component-deep-a-Medium",
            l: "Component-deep-a-Large"
          },
          dp_b: {
            deeper_a: {
              position: {
                right: "Component-deep-b-Right",
                center: "Component-deep-b-Center",
                left: "Component-deep-b-Left"
              }
            }
          }
        }
      }

      # @label add responsive
      def add_responsive
        map = CLASS_MAP
        map_copy = map.deep_dup
        add_responsive_variants!(map_copy)

        panels = [
          {
            title: "base map",
            output: map.pretty_inspect
          }, {
            title: "base map with variants",
            output: map_copy.pretty_inspect
          }
        ]

        render_with_template(
          locals: { panels: panels },
          template: MAIN_TEMPLATE
        )
      end

      # @label to responsive
      def to_responsive
        map = CLASS_MAP
        map_copy = map.deep_dup
        add_responsive_variants!(map_copy, remove_initial: true)

        panels = [
          {
            title: "base map",
            output: map.pretty_inspect
          }, {
            title: "map variants",
            output: map_copy.pretty_inspect
          }
        ]

        render_with_template(
          locals: { panels: panels },
          template: MAIN_TEMPLATE
        )
      end

      # @label class map filtered by values - no responsive
      def class_map_filtered_by_values
        map = CLASS_MAP
        values = {
          prop_a: :value_b,
          prop_b: true,
          prop_c: "1",
          deep_prop: {
            dp_a: :s,
            dp_b: { deeper_a: { position: :center } }
          }
        }

        filtered_map = apply_values_to_style_map(map, values)

        panels = [
          {
            title: "base map",
            output: map.pretty_inspect
          }, {
            title: "values",
            output: values.pretty_inspect
          }, {
            title: "filtered map",
            output: filtered_map.pretty_inspect
          }
        ]

        render_with_template(
          locals: { panels: panels },
          template: MAIN_TEMPLATE
        )
      end

      # @label class map filtered by values - responsive
      def class_map_filtered_by_values_responsive
        map = CLASS_MAP
        values = {
          prop_a: :value_b,
          prop_b: true,
          prop_c: "1",
          deep_prop: {
            dp_a: :s,
            dp_b: { deeper_a: { position: :center } }
          },
          v_narrow: {
            prop_a: :value_a
          },
          v_wide: {
            deep_prop: { dp_a: :l },
            prop_c: "2"
          }
        }

        responsive_map = map.deep_dup
        add_responsive_variants!(responsive_map, remove_initial: true)
        filtered_map = apply_values_to_style_map(responsive_map, values)

        panels = [
          {
            title: "base map",
            output: responsive_map.pretty_inspect
          }, {
            title: "values",
            output: values.pretty_inspect
          }, {
            title: "filtered map",
            output: filtered_map.pretty_inspect
          }
        ]

        render_with_template(
          locals: { panels: panels },
          template: MAIN_TEMPLATE
        )
      end
    end
  end
end
