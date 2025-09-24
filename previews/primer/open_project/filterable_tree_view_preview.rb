# frozen_string_literal: true

module Primer
  module OpenProject
    # @label FilterableTreeView
    class FilterableTreeViewPreview < ViewComponent::Preview
      # @label Playground
      #
      # @param expanded [Boolean] toggle
      # @param show_checkbox [Boolean] toggle
      # @param show_segmented_control [Boolean] toggle
      def playground(expanded: true, show_checkbox: true, show_segmented_control: true)
        render_with_template(locals: {
          expanded: coerce_bool(expanded),
          show_checkbox: coerce_bool(show_checkbox),
          show_segmented_control: coerce_bool(show_segmented_control)
        })
      end

      # @label Default
      #
      # @snapshot interactive
      # @param expanded [Boolean] toggle
      def default(expanded: true)
        render_with_template(locals: {
          expanded: coerce_bool(expanded)
        })
      end

      # @label Form input
      #
      # @param expanded [Boolean] toggle
      def form_input(expanded: true)
        render_with_template(locals: {
          expanded: coerce_bool(expanded)
        })
      end

      # @label Custom segmented control
      #
      # @snapshot interactive
      #
      # ---------------------------
      # ## Custom filter modes
      #
      # In addition to the default filter modes of `'all'` and `'selected'`, `FilterableTreeView` supports
      # adding custom filter modes. Adding a filter mode will cause its label to appear in the `SegmentedControl` in the
      # toolbar, and will be passed as the third argument to the filter function (see below).
      #
      # Here's how to add a custom filter mode in addition to the default ones:
      #
      # ```erb
      # <%= render(Primer::OpenProject::FilterableTreeView.new) do |tree_view| %>
      #   <%# remove this line to prevent adding the default modes %>
      #   <% tree_view.with_default_filter_modes %>
      #   <% tree_view.with_filter_mode(name: "Custom", system_arguments)
      # <% end %>
      # ```
      #
      # ### Customizing the filter function
      #
      # The filter function can be customized by setting the value of the `filterFn` property to a function with the
      # following signature:
      #
      # ```typescript
      # export type FilterFn = (node: HTMLElement, query: string, filterMode?: string) => Range[] | null
      # ```
      #
      # This function will be called once for each node in the tree every time filter controls change (i.e. when the
      # filter mode or query string are altered). The function is called with the following arguments:
      #
      # |Argument    |Description                                                      |
      # |:-----------|:----------------------------------------------------------------|
      # |`node`      |The HTML node element, i.e. the element with `role=treeitem` set.|
      # |`query`     |The query string.                                                |
      # |`filterMode`|The filter mode, either `'all'` or `'selected'`.                 |
      #
      # The component expects the filter function to return specific values depending on the type of match:
      #
      # 1. No match - return `null`
      # 2. Match but no highlights (eg. when the query string is empty) - return an empty array
      # 3. Match with highlights - return a non-empty array of `Range` objects
      #
      # Example:
      #
      # ```javascript
      # const filterableTreeView = document.querySelector('filterable-tree-view')
      # filterableTreeView.filterFn = (node, query, filterMode) => {
      #   // custom filter implementation here
      # }
      # ```
      #
      def custom_segmented_control(expanded: true)
        render_with_template(locals: {
          expanded: coerce_bool(expanded)
        })
      end

      # @label Custom no results text
      def custom_no_results_text(expanded: true)
        render_with_template(locals: {
          expanded: coerce_bool(expanded)
        })
      end

      # @label Custom checkbox text
      def custom_checkbox_text(expanded: true)
        render_with_template(locals: {
          expanded: coerce_bool(expanded)
        })
      end

      # @label Hide checkbox
      #
      # @param include_sub_items [Boolean] toggle
      def hide_checkbox(include_sub_items: true)
        render_with_template(locals: {
          expanded: true,
          include_sub_items: coerce_bool(include_sub_items)
        })
      end

      # @label Hide SegmentedControl
      def hide_segmented_control(expanded: true)
        render_with_template(locals: {
          expanded: coerce_bool(expanded)
        })
      end

      private

      def coerce_bool(value)
        case value
        when true, false
          value
        when "true"
          true
        when "false"
          false
        else
          false
        end
      end
    end
  end
end
