# frozen_string_literal: true

require "components/test_helper"

module Primer
  module OpenProject
    class TreeViewTest < Minitest::Test
      include Primer::ComponentTestHelpers

      def test_dom_structure
        render_preview(:default, params: { expanded: true })

        assert_selector("tree-view") do |tree|
          tree.assert_selector("ul[role=tree]") do |sub_tree|
            sub_tree.assert_selector("li[role=none]") do |node|
              node.assert_selector(".TreeViewItemContainer", text: "src")
              node.assert_selector("ul[role=group]") do |sub_tree|
                sub_tree.assert_selector("li[role=none] [role=treeitem]", text: "button.rb")
                sub_tree.assert_selector("li[role=none] [role=treeitem]", text: "icon_button.rb")
              end
            end
          end
        end
      end

      def test_leading_visual_icon_pair_collapsed
        render_preview(:default)

        assert_selector("[role=treeitem][data-path=\"[\\\"src\\\"]\"]") do |node|
          node.assert_selector(".TreeViewItemVisual tree-view-icon-pair") do |visual|
            visual.assert_selector("svg.octicon-file-directory-fill")
          end
        end
      end

      def test_leading_visual_icon_pair_expanded
        render_preview(:default, params: { expanded: true })

        assert_selector("[role=treeitem][data-path=\"[\\\"src\\\"]\"]") do |node|
          node.assert_selector(".TreeViewItemVisual tree-view-icon-pair") do |visual|
            visual.assert_selector("svg.octicon-file-directory-open-fill")
          end
        end
      end

      def test_trailing_visual_icon
        render_preview(:default)

        assert_selector("[role=treeitem][data-path=\"[\\\"src\\\"]\"]") do |node|
          # this should be visually positioned after the node's label
          node.assert_selector(":nth-child(5) svg.octicon-diff-modified")
        end
      end

      def test_node_described_by_leading_visual
        render_inline(Primer::OpenProject::TreeView.new) do |tree|
          tree.with_leaf(label: "src") do |node|
            node.with_leading_visual_icon(icon: :"file-directory-fill", label: "File folder")
          end
        end

        assert_selector "[data-test-selector='tree-view-visual-label']", text: "File folder"

        label_id = page
          .find_css("[data-test-selector='tree-view-visual-label']")
          .attribute("id")
          .value

        assert_selector "[role=treeitem][aria-describedby='#{label_id}']"
      end

      def test_node_labelled_by_content
        render_inline(Primer::OpenProject::TreeView.new) do |tree|
          tree.with_leaf(label: "src")
        end

        assert_selector ".TreeViewItemContent", text: "src"

        content_id = page
          .find_css(".TreeViewItemContent")
          .attribute("id")
          .value

        assert_selector "[role=treeitem][aria-labelledby='#{content_id}']"
      end

      def test_loading_spinner
        render_preview(:loading_spinner)

        assert_selector("tree-view-include-fragment", visible: :hidden) do |node|
          node.assert_selector("[data-target='tree-view-sub-tree-node.loadingIndicator'] svg", visible: :hidden)
          node.assert_selector("button[data-target='tree-view-sub-tree-node.retryButton']", visible: :hidden)
        end
      end

      def test_loading_skeleton
        render_preview(:loading_skeleton)

        assert_selector("tree-view-include-fragment", visible: :hidden) do |node|
          node.assert_selector("[data-target='tree-view-sub-tree-node.loadingIndicator'] .TreeViewItemSkeleton", visible: :hidden)
          node.assert_selector("button[data-target='tree-view-sub-tree-node.retryButton']", visible: :hidden)
        end
      end

      def test_leaf_leading_action
        render_preview(:leaf_node_playground, params: { leading_action_icon: :grabber })

        assert_selector(".TreeViewItemLeadingAction button svg.octicon-grabber")
      end

      def test_leaf_trailing_visual
        render_preview(:leaf_node_playground, params: { trailing_visual_icon: :"diff-modified" })

        assert_selector("[role=treeitem] .TreeViewItemVisual svg.octicon-diff-modified")
      end

      def test_sub_tree_leading_action
        render_inline(Primer::OpenProject::TreeView.new) do |tree|
          tree.with_sub_tree(label: "src") do |sub_tree|
            sub_tree.with_leading_action_button(icon: :grabber, aria: { label: "Leading action icon" })
            sub_tree.with_leaf(label: "button.rb")
          end
        end

        assert_selector(".TreeViewItemLeadingAction button svg.octicon-grabber")
      end

      def test_sub_tree_leading_visual
        render_inline(Primer::OpenProject::TreeView.new) do |tree|
          tree.with_sub_tree(label: "src") do |sub_tree|
            sub_tree.with_leading_visual_icon(icon: :"sparkle-fill")
            sub_tree.with_leaf(label: "button.rb")
          end
        end

        assert_selector("[role=treeitem] .TreeViewItemVisual svg.octicon-sparkle-fill")
      end

      def test_disallows_multi_select_for_async_sub_trees
        error = assert_raises(ArgumentError) do
          render_inline(Primer::OpenProject::TreeView.new) do |tree|
            tree.with_sub_tree(label: "src", select_variant: :multiple) do |sub_tree|
              sub_tree.with_loading_spinner(src: "/foobar")
            end
          end
        end

        assert_equal error.message, "TreeView does not currently support select variants for sub-trees loaded asynchronously."
      end

      def test_supports_anchor_tags
        render_preview(:links)

        assert_selector "a[role=treeitem]", count: 4, visible: :all
      end

      def test_supports_button_tags
        render_preview(:buttons)

        assert_selector "button[role=treeitem]", count: 4, visible: :all
      end

      def test_disallows_select_variants_for_anchor_tags
        error = assert_raises(ArgumentError) do
          render_inline(Primer::OpenProject::TreeView.new) do |tree|
            tree.with_sub_tree(label: "src", tag: :a, select_variant: :multiple) do |sub_tree|
              sub_tree.with_leaf(label: "button.rb")
            end
          end
        end

        assert_equal error.message, "TreeView nodes do not support select variants for tags other than :div."
      end

      def test_disallows_select_variants_for_button_tags
        error = assert_raises(ArgumentError) do
          render_inline(Primer::OpenProject::TreeView.new) do |tree|
            tree.with_sub_tree(label: "src", tag: :button, select_variant: :multiple) do |sub_tree|
              sub_tree.with_leaf(label: "button.rb")
            end
          end
        end

        assert_equal error.message, "TreeView nodes do not support select variants for tags other than :div."
      end
    end
  end
end
