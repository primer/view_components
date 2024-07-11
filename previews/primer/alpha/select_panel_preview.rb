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
      # @param show_filter toggle
      # @param open_on_load toggle
      # @param anchor_align [Symbol] select [start, center, end]
      # @param anchor_side [Symbol] select [outside_bottom, outside_top, outside_left, outside_right]
      def playground(
        title: "Sci-fi equipment",
        size: :auto,
        simulate_failure: false,
        simulate_no_results: false,
        no_results_label: "No results found",
        dynamic_label: false,
        dynamic_label_prefix: nil,
        dynamic_aria_label_prefix: nil,
        show_filter: true,
        open_on_load: false,
        anchor_align: :start,
        anchor_side: :outside_bottom
      )
        render_with_template(locals: {
          system_arguments: {
            title: title,
            size: size,
            simulate_failure: simulate_failure,
            simulate_no_results: simulate_no_results,
            no_results_label: no_results_label,
            dynamic_label: dynamic_label,
            dynamic_label_prefix: dynamic_label_prefix,
            dynamic_aria_label_prefix: dynamic_aria_label_prefix,
            show_filter: show_filter,
            open_on_load: open_on_load,
            anchor_align: anchor_align,
            anchor_side: anchor_side
          }
        })
      end

      # @label Default
      #
      # @param open_on_load toggle
      def default(open_on_load: false)
        render_with_template(template: "primer/alpha/select_panel_preview/local_fetch", locals: {
          open_on_load: open_on_load
        })
      end

      # @!group Fetch strategies

      # @label Local fetch
      #
      # @param open_on_load toggle
      def local_fetch(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @label Eventually local fetch
      #
      # @param open_on_load toggle
      def eventually_local_fetch(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @label Remote fetch
      #
      # @param open_on_load toggle
      def remote_fetch(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @label Local fetch (no results)
      #
      # @param open_on_load toggle
      def local_fetch_no_results(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @label Eventually local fetch (no results)
      #
      # @param open_on_load toggle
      def eventually_local_fetch_no_results(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @label Remote fetch (no results)
      #
      # @param open_on_load toggle
      def remote_fetch_no_results(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @!endgroup

      # @label Single select
      #
      # @param dynamic_label toggle
      # @param open_on_load toggle
      def single_select(dynamic_label: false, open_on_load: false)
        render_with_template(locals: { dynamic_label: dynamic_label, open_on_load: open_on_load })
      end

      # @label Multiselect
      #
      # @param open_on_load toggle
      def multiselect(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @!group Dynamic label

      # @label With dynamic label
      #
      # @param open_on_load toggle
      def with_dynamic_label(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @param open_on_load toggle
      def with_dynamic_label_and_aria_prefix(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @!endgroup

      # @label Footer buttons
      #
      # @param open_on_load toggle
      def footer_buttons(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @label With avatar items
      #
      # @param open_on_load toggle
      def with_avatar_items(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @!group With icons

      # @label With leading icons
      #
      # @param open_on_load toggle
      def with_leading_icons(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @label With trailing icons
      #
      # @param open_on_load toggle
      def with_trailing_icons(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @!endgroup

      # @label With subtitle
      #
      # @param open_on_load toggle
      def with_subtitle(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @label Remote fetch initial failure
      #
      # @param open_on_load toggle
      def remote_fetch_initial_failure(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @label Remote fetch filter failure
      #
      # @param open_on_load toggle
      def remote_fetch_filter_failure(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end

      # @label Eventually local fetch initial failure
      #
      # @param open_on_load toggle
      def eventually_local_fetch_initial_failure(open_on_load: false)
        render_with_template(locals: { open_on_load: open_on_load })
      end
    end
  end
end
