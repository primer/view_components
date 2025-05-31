# frozen_string_literal: true

module Primer
  module OpenProject
    # A TreeView and associated filter controls for searching nested hierarchies.
    class FilterableTreeView < Primer::Component
      delegate :with_leaf, :with_sub_tree, to: :@tree_view

      DEFAULT_FILTER_INPUT_ARGUMENTS = {
        name: :filter,
        label: "Filter",
        type: :search,
        leading_visual: { icon: :search },
        visually_hide_label: true,
      }

      DEFAULT_FILTER_INPUT_ARGUMENTS.freeze

      DEFAULT_FILTER_MODE_CONTROL_ARGUMENTS = {
        aria: {
          label: "Filter mode"
        }
      }

      DEFAULT_FILTER_MODE_CONTROL_ARGUMENTS.freeze

      DEFAULT_INCLUDE_SUB_ITEMS_CHECK_BOX_ARGUMENTS = {
        label: "Include sub-items",
        name: :include_sub_items,
        html: { form: "" }, # exclude from form submissions
      }

      DEFAULT_INCLUDE_SUB_ITEMS_CHECK_BOX_ARGUMENTS.freeze

      DEFAULT_FILTER_MODES = {
        all: {
          label: "All",
          selected: true,
        },

        selected: {
          label: "Selected",
        }
      }

      DEFAULT_FILTER_MODES.freeze

      def initialize(
        tree_view_arguments: {},
        form_arguments: {},
        filter_input_arguments: DEFAULT_FILTER_INPUT_ARGUMENTS.dup,
        filter_mode_control_arguments: DEFAULT_FILTER_MODE_CONTROL_ARGUMENTS.dup,
        include_sub_items_check_box_arguments: DEFAULT_INCLUDE_SUB_ITEMS_CHECK_BOX_ARGUMENTS.dup,
        **system_arguments
      )
        tree_view_arguments[:data] = merge_data(
          tree_view_arguments, {
            data: { target: "filterable-tree-view.treeViewList" }
          }
        )

        @tree_view = Primer::OpenProject::TreeView.new(
          form_arguments: form_arguments,
          **tree_view_arguments
        )

        filter_input_arguments[:data] = merge_data(
          filter_input_arguments, {
            data: { target: "filterable-tree-view.filterInput" }
          }
        )

        @filter_input = Primer::Alpha::TextField.new(**filter_input_arguments)

        filter_mode_control_arguments[:data] = merge_data(
          filter_mode_control_arguments, {
            data: { target: "filterable-tree-view.filterModeControlList" }
          }
        )

        @filter_mode_control = Primer::Alpha::SegmentedControl.new(**filter_mode_control_arguments)

        include_sub_items_check_box_arguments[:data] = merge_data(
          include_sub_items_check_box_arguments, {
            data: { target: "filterable-tree-view.includeSubItemsCheckBox" }
          }
        )

        @include_sub_items_check_box = Primer::Alpha::CheckBox.new(**include_sub_items_check_box_arguments)

        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :"filterable-tree-view"
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

        if @filter_mode_control.items.empty?
          with_default_filter_modes
        end
      end
    end
  end
end
