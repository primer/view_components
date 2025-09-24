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

      def test_segmented_control_can_be_hidden
        render_inline(
          Primer::OpenProject::FilterableTreeView.new(
            filter_mode_control_arguments: :none
          )
        )

        assert_no_selector("segmented-control")
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

      def test_sub_trees_cannot_load_with_async_spinner
        error = assert_raises(ArgumentError) do
          render_inline(Primer::OpenProject::FilterableTreeView.new) do |tree|
            tree.with_sub_tree(label: "Foo") do |sub_tree|
              sub_tree.with_loading_spinner(href: "/foo")
            end
          end
        end

        assert_equal error.message, "FilteredTreeView does not support asynchronous loading"
      end

      def test_sub_trees_cannot_load_with_async_skeleton
        error = assert_raises(ArgumentError) do
          render_inline(Primer::OpenProject::FilterableTreeView.new) do |tree|
            tree.with_sub_tree(label: "Foo") do |sub_tree|
              sub_tree.with_loading_skeleton(href: "/foo")
            end
          end
        end

        assert_equal error.message, "FilteredTreeView does not support asynchronous loading"
      end

      def test_custom_filter_modes
        render_inline(Primer::OpenProject::FilterableTreeView.new) do |tree|
          tree.with_default_filter_modes
          tree.with_filter_mode(name: :foo, label: "Foo")
        end

        assert_selector "segmented-control li", text: "Foo"
      end
    end
  end
end
