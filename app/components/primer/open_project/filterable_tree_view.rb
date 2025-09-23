# frozen_string_literal: true

module Primer
  module OpenProject
    # A TreeView and associated filter controls for searching nested hierarchies.
    #
    # ## Filter controls
    #
    # `FilterableTreeView`s can be filtered using two controls, both present in the toolbar above the tree:
    #
    # 1. A free-form query string from a text input field.
    # 2. A `SegmentedControl` with two options (by default):
    #    1. The "Selected" option causes the component to only show checked nodes, provided they also satisfy the other
    #       filter criteria described here.
    #    2. The "All" option causes the component to show all nodes, provided they also satisfy the other filter
    #       criteria described here.
    #
    # ## Custom filter modes
    #
    # In addition to the default filter modes of `'all'` and `'selected'` described above, `FilterableTreeView` supports
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
    # ## Filter behavior
    #
    # By default, matching node text is identified by looking for an exact substring match, operating on a lowercased
    # version of both the query string and the node text. For more information, and to provide a customized filter
    # function, please see the section titled "Customizing the filter function" below.
    #
    # Nodes that match the filter appear as normal; nodes that do not match are presented as follows:
    #
    # 1. Leaf nodes are hidden.
    # 2. Sub-tree nodes with no matching children are hidden.
    # 3. Sub-tree nodes with at least one matching child are disabled but still visible.
    #
    # ## Checking behavior
    #
    # By default, checking a node in a `FilterableTreeView` checks only that node (i.e. no child nodes are checked).
    # To aide in checking children in deeply nested or highly populated hierarchies, a third control exists in the
    # toolbar: the "Include sub-items" check box. If this feature is turned on, checking sub-tree nodes causes all
    # children, both leaf and sub-tree nodes, to also be checked recursively. Moreover, turning this feature on will
    # cause the children of any previously checked nodes to be checked recursively. Unchecking a node while in
    # "Include sub-items" mode will restore that sub-tree and all its children to their previously checked state, so as
    # not to permanently override a user's selections. Unchecking the "Include sub-items" check box has a similar effect,
    # i.e. restores all previous user selections under currently checked sub-trees.
    #
    # ## JavaScript API
    #
    # `FilterableTreeView` does not yet have an extensive JavaScript API, but this may change in the future as the
    # component is further developed to fit additional use-cases.
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
    # You can read about `Range` objects here: https://developer.mozilla.org/en-US/docs/Web/API/Range.
    #
    # For a complete example demonstrating how to implement a working filter function complete with range highlighting,
    # see the default filter function available in the `FilterableTreeViewElement` JavaScript class, which is part of
    # the Primer source code.
    #
    # ### Events
    #
    # Currently `FilterableTreeView` does not emit any events aside from the events already emitted by the `TreeView`
    # component.
    class FilterableTreeView < Primer::Component
      delegate :with_leaf, :with_sub_tree, to: :@tree_view

      DEFAULT_FILTER_INPUT_ARGUMENTS = {
        name: :filter,
        label: I18n.t(:button_filter),
        type: :search,
        leading_visual: { icon: :search },
        visually_hide_label: true,
        show_clear_button: true,
      }

      DEFAULT_FILTER_INPUT_ARGUMENTS.freeze

      DEFAULT_FILTER_MODE_CONTROL_ARGUMENTS = {
        aria: {
          label: I18n.t("filterable_tree_view.filter_mode.label")
        }
      }

      DEFAULT_FILTER_MODE_CONTROL_ARGUMENTS.freeze

      DEFAULT_INCLUDE_SUB_ITEMS_CHECK_BOX_ARGUMENTS = {
        label: I18n.t("filterable_tree_view.include_sub_items"),
        name: :include_sub_items
      }

      DEFAULT_INCLUDE_SUB_ITEMS_CHECK_BOX_ARGUMENTS.freeze

      DEFAULT_FILTER_MODES = {
        all: {
          label: I18n.t("filterable_tree_view.filter_mode.all"),
          selected: true,
        },

        selected: {
          label: I18n.t("filterable_tree_view.filter_mode.selected"),
        }
      }

      DEFAULT_FILTER_MODES.freeze

      DEFAULT_NO_RESULTS_NODE_ARGUMENTS = {
        label: I18n.t("filterable_tree_view.no_results_text")
      }

      DEFAULT_NO_RESULTS_NODE_ARGUMENTS.freeze

      # @param tree_view_arguments [Hash] Arguments that will be passed to the underlying <%= link_to_component(Primer::Alpha::TreeView) %> component.
      # @param form_arguments [Hash] Form arguments that will be passed to the underlying <%= link_to_component(Primer::Alpha::TreeView) %> component. These arguments allow the selections made within a `FilterableTreeView` to be submitted to the server as part of a Rails form. Pass the `builder:` and `name:` options to this hash. `builder:` should be an instance of `ActionView::Helpers::FormBuilder`, which are created by the standard Rails `#form_with` and `#form_for` helpers. The `name:` option is the desired name of the field that will be included in the params sent to the server on form submission.
      # @param filter_input_arguments [Hash] Arguments that will be passed to the <%= link_to_component(Primer::Alpha::TextField) %> component.
      # @param filter_mode_control_arguments [Hash] Arguments that will be passed to the <%= link_to_component(Primer::Alpha::SegmentedControl) %> component.
      # @param include_sub_items_check_box_arguments [Hash] Arguments that will be passed to the <%= link_to_component(Primer::Alpha::CheckBox) %> component.
      # @param no_results_node_arguments [Hash] Arguments that will be passed to a <%= link_to_component(Primer::Alpha::TreeView::LeafNode) %> component that appears when no items match the filter criteria.
      def initialize(
        tree_view_arguments: {},
        form_arguments: {},
        filter_input_arguments: DEFAULT_FILTER_INPUT_ARGUMENTS.dup,
        filter_mode_control_arguments: DEFAULT_FILTER_MODE_CONTROL_ARGUMENTS.dup,
        include_sub_items_check_box_arguments: DEFAULT_INCLUDE_SUB_ITEMS_CHECK_BOX_ARGUMENTS.dup,
        no_results_node_arguments: DEFAULT_NO_RESULTS_NODE_ARGUMENTS.dup,
        **system_arguments
      )
        tree_view_arguments[:data] = merge_data(
          tree_view_arguments, {
            data: { target: "filterable-tree-view.treeViewList" }
          }
        )

        @tree_view = Primer::Alpha::TreeView.new(
          form_arguments: form_arguments,
          **tree_view_arguments
        )

        filter_input_arguments[:data] = merge_data(
          filter_input_arguments, {
            data: { target: "filterable-tree-view.filterInput" }
          }
        )

        @filter_input = Primer::Alpha::TextField.new(**filter_input_arguments)

        unless filter_mode_control_arguments == :none
          filter_mode_control_arguments[:data] = merge_data(
            filter_mode_control_arguments, {
              data: { target: "filterable-tree-view.filterModeControlList" }
            }
          )

          @filter_mode_control = Primer::Alpha::SegmentedControl.new(**filter_mode_control_arguments)
        end

        include_sub_items_check_box_arguments[:data] = merge_data(
          include_sub_items_check_box_arguments, {
            data: { target: "filterable-tree-view.includeSubItemsCheckBox" }
          }
        )

        @include_sub_items_check_box = Primer::Alpha::CheckBox.new(**include_sub_items_check_box_arguments)

        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :"filterable-tree-view"

        @no_results_node_arguments = no_results_node_arguments
      end

      def with_default_filter_modes
        DEFAULT_FILTER_MODES.each do |name, system_arguments|
          with_filter_mode(name: name, **system_arguments)
        end
      end

      def with_filter_mode(name:, **system_arguments)
        system_arguments[:data] = merge_data(
          system_arguments, {
            data: { name: name }
          }
        )

        @filter_mode_control.with_item(**system_arguments)
      end

      def with_sub_tree(**system_arguments, &block)
        @tree_view.with_sub_tree(
          sub_tree_component_klass: SubTree,
          **system_arguments,
          select_variant: :multiple,
          select_strategy: :self,
          &block
        )
      end

      def with_leaf(**system_arguments, &block)
        @tree_view.with_leaf(
          **system_arguments,
          select_variant: :multiple,
          &block
        )
      end

      private

      def before_render
        content

        if @filter_mode_control.present? && @filter_mode_control.items.empty?
          with_default_filter_modes
        end
      end
    end
  end
end
