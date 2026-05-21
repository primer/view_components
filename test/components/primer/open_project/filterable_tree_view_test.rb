# frozen_string_literal: true

require "components/test_helper"

module Primer
  module OpenProject
    class FilterableTreeViewTest < Minitest::Test
      include Primer::ComponentTestHelpers

      def test_has_filter_mode_controls
        render_preview(:default)

        assert_selector("segmented-control [role=list][aria-label='Filter mode']") do |controls|
          controls.assert_selector(".SegmentedControl-item", text: "All")
          controls.assert_selector(".SegmentedControl-item", text: "Selected")
        end
      end

      def test_filter_mode_control_item_labels_can_be_overridden
        render_inline(Primer::OpenProject::FilterableTreeView.new) do |tree|
          tree.with_filter_mode(
            name: :all,
            **Primer::OpenProject::FilterableTreeView::DEFAULT_FILTER_MODES[:all].merge(
              label: "Alle"
            )
          )

          tree.with_filter_mode(
            name: :selected,
            **Primer::OpenProject::FilterableTreeView::DEFAULT_FILTER_MODES[:selected].merge(
              label: "Ausgewählt"
            )
          )
        end

        assert_selector("segmented-control [role=list][aria-label='Filter mode']") do |controls|
          controls.assert_selector(".SegmentedControl-item", text: "Alle")
          controls.assert_selector(".SegmentedControl-item", text: "Ausgewählt")
        end
      end

      def test_filter_mode_control_label_can_be_overridden
        render_inline(
          Primer::OpenProject::FilterableTreeView.new(
            filter_mode_control_arguments: {
              aria: { label: "Filtermodus" }
            }
          )
        )

        assert_selector("segmented-control [role=list][aria-label='Filtermodus']")
      end

      def test_filter_mode_control_can_be_hidden
        render_inline(
          Primer::OpenProject::FilterableTreeView.new(
            filter_mode_control_arguments: { hidden: true }
          )
        )

        assert_selector("segmented-control", visible: :hidden)
      end

      def test_has_include_sub_items_check_box
        render_preview(:default)

        input = page.find_css("input[type=checkbox][name='include_sub_items']").first
        assert input

        id = input["id"]
        assert_selector("label[for='#{id}']", text: "Include sub-items")
      end

      def test_include_sub_items_can_be_hidden
        render_inline(
          Primer::OpenProject::FilterableTreeView.new(
            include_sub_items_check_box_arguments: { hidden: true }
          )
        )

        assert_selector(".FormControl-checkbox-wrap", visible: :hidden)
        assert_selector("input[name=include_sub_items]", visible: :hidden)
      end

      def test_include_sub_items_can_have_a_different_default
        render_inline(
          Primer::OpenProject::FilterableTreeView.new(
            include_sub_items_check_box_arguments: { checked: true }
          )
        )

        assert_selector(".FormControl-checkbox-wrap", visible: :visible)
        assert_selector("input[name=include_sub_items][checked=checked]", visible: :visible)
      end

      def test_include_sub_items_is_hidden_for_single_select_variant
        render_preview(:form_input, params: { select_variant: :single })

        assert_selector(".FormControl-checkbox-wrap", visible: :hidden)
        assert_selector("input[name=include_sub_items]:not([checked=false])", visible: :hidden)
        assert_selector("segmented-control", visible: :visible)
      end

      def test_has_filter_input
        render_preview(:default)

        input = page.find_css("input[type=search][name=filter]").first
        assert input

        id = input["id"]
        assert_selector("label[for='#{id}'].sr-only", text: "Filter")
      end

      def test_filter_input_arguments_can_be_overridden
        render_inline(
          Primer::OpenProject::FilterableTreeView.new(
            filter_input_arguments: Primer::OpenProject::FilterableTreeView::DEFAULT_FILTER_INPUT_ARGUMENTS.merge(
              label: "Filtern"
            )
          )
        )

        input = page.find_css("input[type=search][name=filter]").first
        assert input

        id = input["id"]
        assert_selector("label[for='#{id}'].sr-only", text: "Filtern")
      end

      def test_leaf_renders_with_select_variant_none
        render_inline(Primer::OpenProject::FilterableTreeView.new(tree_view_arguments: { node_variant: :anchor })) do |tree|
          tree.with_leaf(label: "Foo", select_variant: :none, href: "/foo")
        end

        assert_selector "[role=treeitem][href='/foo']"
      end

      def test_leaf_in_sub_tree_renders_with_select_variant_none
        render_inline(Primer::OpenProject::FilterableTreeView.new(tree_view_arguments: { node_variant: :anchor })) do |tree|
          tree.with_sub_tree(label: "Foo", select_variant: :none, expanded: true) do |sub_tree|
            sub_tree.with_leaf(label: "Bar", select_variant: :none, href: "/bar")
          end
        end

        assert_selector "[role=treeitem][href='/bar']"
      end

      def test_sub_tree_renders_with_select_variant_none
        render_inline(Primer::OpenProject::FilterableTreeView.new) do |tree|
          tree.with_sub_tree(label: "Foo", select_variant: :none) do |sub_tree|
            sub_tree.with_leaf(label: "Bar", select_variant: :none)
          end
        end

        assert_selector "[role=treeitem][data-select-variant=none]", text: "Foo"
      end

      def test_nested_sub_tree_renders_with_select_variant_none
        render_inline(Primer::OpenProject::FilterableTreeView.new) do |tree|
          tree.with_sub_tree(label: "Foo", select_variant: :none, expanded: true) do |sub_tree|
            sub_tree.with_sub_tree(label: "Bar", select_variant: :none) do |nested|
              nested.with_leaf(label: "Baz", select_variant: :none)
            end
          end
        end

        assert_selector "[role=treeitem][data-select-variant=none]", text: "Bar"
      end

      def test_include_sub_items_is_hidden_for_none_select_variant_via_leaf
        render_inline(Primer::OpenProject::FilterableTreeView.new) do |tree|
          tree.with_leaf(label: "Foo", select_variant: :none)
        end

        assert_selector(".FormControl-checkbox-wrap", visible: :hidden)
        assert_selector("segmented-control", visible: :visible)
      end

      def test_include_sub_items_is_hidden_for_none_select_variant_via_sub_tree
        render_inline(Primer::OpenProject::FilterableTreeView.new) do |tree|
          tree.with_sub_tree(label: "Foo", select_variant: :none) do |sub_tree|
            sub_tree.with_leaf(label: "Bar", select_variant: :none)
          end
        end

        assert_selector(".FormControl-checkbox-wrap", visible: :hidden)
        assert_selector("segmented-control", visible: :visible)
      end

      def test_segmented_control_remains_visible_for_none_select_variant_with_custom_filter_mode
        render_inline(Primer::OpenProject::FilterableTreeView.new) do |tree|
          tree.with_filter_mode(name: :active, label: "Active")
          tree.with_filter_mode(name: :favourite, label: "Favourite")
          tree.with_leaf(label: "Foo", select_variant: :none)
        end

        assert_selector("segmented-control", visible: :visible)
        assert_selector(".SegmentedControl-item", text: "Active")
      end

      def test_leaf_cannot_render_with_unsupported_select_variant
        expected_message = "FilterableTreeView only supports :multiple, :single, and :none as select_variant"

        error = assert_raises(ArgumentError) do
          render_inline(Primer::OpenProject::FilterableTreeView.new) do |tree|
            tree.with_leaf(label: "Foo", select_variant: :foo)
          end
        end

        assert_equal expected_message, error.message

        error = assert_raises(ArgumentError) do
          render_inline(Primer::OpenProject::FilterableTreeView.new) do |tree|
            tree.with_sub_tree(label: "Foo") do |sub_tree|
              sub_tree.with_leaf(label: "Bar", select_variant: :foo)
            end
          end
        end

        assert_equal expected_message, error.message
      end

      def test_sub_trees_cannot_render_with_unsupported_select_variant
        expected_message = "FilterableTreeView only supports :multiple, :single, and :none as select_variant"

        error = assert_raises(ArgumentError) do
          render_inline(Primer::OpenProject::FilterableTreeView.new) do |tree|
            tree.with_sub_tree(label: "Foo", select_variant: :foo)
          end
        end

        assert_equal expected_message, error.message

        error = assert_raises(ArgumentError) do
          render_inline(Primer::OpenProject::FilterableTreeView.new) do |tree|
            tree.with_sub_tree(label: "Foo") do |sub_tree|
              sub_tree.with_sub_tree(label: "Bar", select_variant: :foo)
            end
          end
        end

        assert_equal expected_message, error.message
      end

      def test_sub_trees_cannot_load_with_async_spinner
        error = assert_raises(ArgumentError) do
          render_inline(Primer::OpenProject::FilterableTreeView.new) do |tree|
            tree.with_sub_tree(label: "Foo") do |sub_tree|
              sub_tree.with_loading_spinner(href: "/foo")
            end
          end
        end

        assert_equal error.message, "FilterableTreeView does not support select variants for sub-trees loaded asynchronously. Please make the whole component load asynchronously."
      end

      def test_sub_trees_cannot_load_with_async_skeleton
        error = assert_raises(ArgumentError) do
          render_inline(Primer::OpenProject::FilterableTreeView.new) do |tree|
            tree.with_sub_tree(label: "Foo") do |sub_tree|
              sub_tree.with_loading_skeleton(href: "/foo")
            end
          end
        end

        assert_equal error.message, "FilterableTreeView does not support select variants for sub-trees loaded asynchronously. Please make the whole component load asynchronously."
      end

      def test_custom_filter_modes
        render_inline(Primer::OpenProject::FilterableTreeView.new) do |tree|
          tree.with_default_filter_modes
          tree.with_filter_mode(name: :foo, label: "Foo")
        end

        assert_selector "segmented-control li", text: "Foo"
      end

      # ─── Async mode ────────────────────────────────────────────────────────

      def test_src_attribute_is_set_when_src_is_provided
        render_inline(Primer::OpenProject::FilterableTreeView.new(src: "/my/tree"))

        assert_selector "filterable-tree-view[src='/my/tree']"
      end

      def test_src_attribute_is_absent_when_src_is_not_provided
        render_inline(Primer::OpenProject::FilterableTreeView.new)

        assert_selector "filterable-tree-view:not([src])"
      end

      def test_include_sub_items_checkbox_is_excluded_from_form_in_non_async_mode
        render_preview(:form_input)

        # form="" attribute causes the browser to disassociate the input from any form
        input = page.find_css("input[name=include_sub_items]").first
        assert_equal "", input["form"]
      end

      def test_include_sub_items_checkbox_is_included_in_form_in_async_mode
        render_preview(:async_form_input)

        # In async mode the checkbox must reach the server so it can handle descendants correctly;
        # therefore it must NOT carry the form="" exclusion attribute.
        input = page.find_css("input[name=include_sub_items]").first
        assert_nil input["form"]
      end

      def test_raises_when_tree_view_arguments_provided_alongside_src
        error = assert_raises(ArgumentError) do
          render_inline(
            Primer::OpenProject::FilterableTreeView.new(
              src: "/my/tree",
              tree_view_arguments: { aria: { label: "tree" } }
            )
          )
        end

        assert_equal error.message, "tree_view_arguments are not supported when src: is provided. " \
          "The initial tree shell is replaced on the first async fetch, so any " \
          "tree_view_arguments would be lost. Configure the tree in your server endpoint instead."
      end
    end
  end
end
