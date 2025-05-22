# frozen_string_literal: true

require "components/test_helper"

module Primer
  module OpenProject
    class FileTreeViewTest < Minitest::Test
      include Primer::ComponentTestHelpers

      def test_dom_structure
        render_preview(:default, params: { expanded: true })

        assert_selector("tree-view") do |tree|
          tree.assert_selector("ul[role=tree]") do |sub_tree|
            sub_tree.assert_selector("li[role=none]") do |list_item|
              list_item.assert_selector(".TreeViewItemContainer") do |src_node|
                src_node.assert_selector("[role=treeitem]", text: "src")
                src_node.assert_selector(".TreeViewItemVisual tree-view-icon-pair") do |visual|
                  visual.assert_selector("[data-target='tree-view-icon-pair.expandedIcon'] svg.octicon-file-directory-open-fill")
                  visual.assert_selector("[data-target='tree-view-icon-pair.collapsedIcon'] svg.octicon-file-directory-fill", visible: :hidden)
                end
              end

              list_item.assert_selector("ul[role=group]") do |sub_tree|
                sub_tree.assert_selector("li[role=none] .TreeViewItemContainer") do |button_list_item|
                  button_list_item.assert_selector("[role=treeitem]", text: "button.rb") do |button_node|
                    button_node.assert_selector(".TreeViewItemVisual svg.octicon-file")
                  end
                end

                sub_tree.assert_selector("li[role=none] .TreeViewItemContainer") do |icon_button_node|
                  list_item.assert_selector("[role=treeitem]", text: "icon_button.rb") do |icon_node|
                    icon_node.assert_selector(".TreeViewItemVisual svg.octicon-file")
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
