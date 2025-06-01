# frozen_string_literal: true

module Primer
  module TreeViewHelpers
    def selector_for(*path)
      "[role=treeitem][data-path='#{path.to_json}']"
    end

    def activate_at_path(*path)
      find("#{selector_for(*path)}", match: :first).click
    end

    def expand_at_path(*path)
      node_at_path(*path).sibling(".TreeViewItemToggle").click
    end

    alias collapse_at_path expand_at_path

    def check_at_path(*path)
      # NOTE: clicking anywhere on a node with a checkbox will check/uncheck it, but
      # we target the checkbox element specifically here so this method will fail if
      # no checkbox exists
      find("#{selector_for(*path)} .TreeViewItemCheckbox", match: :first).click
    end

    def label_at_path(*path)
      label_of(node_at_path(*path))
    end

    def label_of(node)
      return unless node
      return unless node["role"] == "treeitem"

      node.find_css(".TreeViewItemContentText").first.all_text
    end

    def node_at_path(*path)
      find(selector_for(*path), match: :first)
    end

    def current_node
      find_all("[role=treeitem][aria-current]").first
    end

    def active_element
      page.evaluate_script("document.activeElement")
    end

    def assert_path(*path)
      assert_selector selector_for(*path)
    end

    def refute_path(*path)
      refute_selector selector_for(*path)
    end

    def assert_path_tabbable(*path)
      assert_selector "#{selector_for(*path)}[tabindex='0']"
    end

    def assert_path_selected(*path)
      assert_selector "#{selector_for(*path)}[aria-selected=true]"
    end

    def assert_path_checked(*path, value: :true)
      assert_selector "#{selector_for(*path)}[aria-checked='#{value}']"
    end

    def refute_path_checked(*path, value: :true)
      if value == :true_or_mixed
        refute_path_checked(*path, "true")
        refute_path_checked(*path, "mixed")
      else
        refute_selector "#{selector_for(*path)}[aria-checked='#{value}']"
      end
    end
  end
end
