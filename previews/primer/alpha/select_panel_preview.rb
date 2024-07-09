# frozen_string_literal: true

module Primer
  module Alpha
    # @label SelectPanel
    class SelectPanelPreview < ViewComponent::Preview
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
