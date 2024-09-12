# frozen_string_literal: true

module Primer
  module Alpha
    # @label SelectPanel
    class SelectPanelPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param title text
      # @param size [Symbol] select [auto, small, medium, medium_portrait, large, xlarge]
      # @param simulate_failure toggle
      # @param simulate_no_results toggle
      # @param no_results_label text
      # @param dynamic_label toggle
      # @param dynamic_label_prefix text
      # @param dynamic_aria_label_prefix text
      # @param open_on_load toggle
      # @param anchor_align [Symbol] select [start, center, end]
      # @param anchor_side [Symbol] select [outside_bottom, outside_top, outside_left, outside_right]
      # @param selected_items text
      def playground(
        title: "Sci-fi equipment",
        subtitle: "Various tools from your favorite shows",
        size: :auto,
        simulate_failure: false,
        simulate_no_results: false,
        no_results_label: "No results found",
        dynamic_label: false,
        dynamic_label_prefix: nil,
        dynamic_aria_label_prefix: nil,
        open_on_load: false,
        anchor_align: :start,
        anchor_side: :outside_bottom,
        selected_items: "Phaser"
      )
        render_with_template(locals: {
          subtitle: subtitle,
          selected_items: selected_items,
          system_arguments: {
            title: title,
            size: size,
            simulate_failure: simulate_failure,
            simulate_no_results: simulate_no_results,
            no_results_label: no_results_label,
            dynamic_label: dynamic_label,
            dynamic_label_prefix: dynamic_label_prefix,
            dynamic_aria_label_prefix: dynamic_aria_label_prefix,
            open_on_load: open_on_load,
            anchor_align: anchor_align,
            anchor_side: anchor_side
          }
        })
      end

      # @label Default
      #
      # @snapshot interactive
      # @param open_on_load toggle
      # @param show_filter toggle
      def default(open_on_load: false, show_filter: true)
        render_with_template(template: "primer/alpha/select_panel_preview/local_fetch", locals: {
          open_on_load: open_on_load,
          show_filter: show_filter
        })
      end

      # @label Local fetch
      #
      # @snapshot interactive
      # @param open_on_load toggle
      # @param show_filter toggle
      def local_fetch(open_on_load: false, show_filter: true)
        render_with_template(locals: { open_on_load: open_on_load, show_filter: show_filter })
      end

      # @label Eventually local fetch
      #
      # @snapshot interactive
      # @param open_on_load toggle
      # @param show_filter toggle
      def eventually_local_fetch(open_on_load: false, show_filter: true)
        render_with_template(locals: { open_on_load: open_on_load, show_filter: show_filter })
      end

      # @label Remote fetch
      #
      # @snapshot interactive
      # @param open_on_load toggle
      # @param selected_items text
      def remote_fetch(open_on_load: false, selected_items: "Phaser")
        render_with_template(locals: { open_on_load: open_on_load, selected_items: selected_items })
      end

      # @label Local fetch (no results)
      #
      # @snapshot interactive
      # @param open_on_load toggle
      def local_fetch_no_results(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @label Eventually local fetch (no results)
      #
      # @snapshot interactive
      # @param open_on_load toggle
      def eventually_local_fetch_no_results(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @label Remote fetch (no results)
      #
      # @snapshot interactive
      # @param open_on_load toggle
      def remote_fetch_no_results(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @label Single select
      #
      # @snapshot interactive
      # @param dynamic_label toggle
      # @param open_on_load toggle
      def single_select(dynamic_label: false, open_on_load: false)
        render_with_template(locals: { dynamic_label: dynamic_label, open_on_load: open_on_load })
      end

      # @label Multiselect
      #
      # @snapshot interactive
      # @param open_on_load toggle
      def multiselect(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @!group Dynamic label

      # @label With dynamic label
      #
      # @snapshot interactive
      # @param open_on_load toggle
      def with_dynamic_label(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @label With dynamic label and aria prefix
      #
      # @snapshot interactive
      # @param open_on_load toggle
      def with_dynamic_label_and_aria_prefix(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @!endgroup

      # @label Footer buttons
      #
      # @snapshot interactive
      # @param open_on_load toggle
      def footer_buttons(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @label With avatar items
      #
      # @snapshot interactive
      # @param open_on_load toggle
      def with_avatar_items(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @!group With icons

      # @label With leading icons
      #
      # @snapshot interactive
      # @param open_on_load toggle
      def with_leading_icons(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @label With trailing icons
      #
      # @snapshot interactive
      # @param open_on_load toggle
      def with_trailing_icons(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @!endgroup

      # @label With subtitle
      #
      # @snapshot interactive
      # @param open_on_load toggle
      def with_subtitle(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @label Remote fetch initial failure
      #
      # @snapshot interactive
      # @param open_on_load toggle
      def remote_fetch_initial_failure(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @label Remote fetch filter failure
      #
      # @snapshot interactive
      # @param open_on_load toggle
      # @param banner_variant [Symbol] select [danger, warning]
      def remote_fetch_filter_failure(
        open_on_load: false,
        banner_variant: :danger
      )
        render_with_template(locals: {
          open_on_load: open_on_load,
          system_arguments: {
            banner_variant: banner_variant.to_sym
          }
        })
      end

      # @label Eventually local fetch initial failure
      #
      # @snapshot interactive
      # @param open_on_load toggle
      def eventually_local_fetch_initial_failure(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @label Single-select form
      #
      # @snapshot interactive
      # @param open_on_load toggle
      def single_select_form(open_on_load: false, route_format: :html)
        render_with_template(locals: { open_on_load: open_on_load, route_format: route_format })
      end

      # @label Multi-select form
      #
      # @snapshot interactive
      # @param open_on_load toggle
      def multiselect_form(open_on_load: false, route_format: :html)
        render_with_template(locals: { open_on_load: open_on_load, route_format: route_format })
      end

      # @label List of links
      #
      # @snapshot interactive
      # @param open_on_load toggle
      def list_of_links(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @label No values
      #
      # @snapshot interactive
      # @param open_on_load toggle
      def no_values(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end
    end
  end
end
