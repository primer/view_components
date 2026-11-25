# frozen_string_literal: true

require "system/test_case"

module Beta
  class IntegrationMarkdownTest < System::TestCase
    include Primer::KeyboardTestHelpers

    def setup
      super
      skip "Requires Chrome's accessibility protocol" unless Primer::DriverTestHelpers.chrome?
    end

    def test_default_task_list_accessibility
      assert_preview_task_lists(:default, "light", 1)
    end

    def test_playground_task_list_accessibility
      assert_preview_task_lists(:playground, "light", 1)
    end

    def test_default_task_list_accessibility_in_all_themes
      assert_preview_task_lists(:default, "all", 7)
    end

    def test_playground_task_list_accessibility_in_all_themes
      assert_preview_task_lists(:playground, "all", 7)
    end

    private

    def assert_preview_task_lists(preview, theme, copy_count)
      # The full Markdown fixture is excluded from axe; inspect its task-list tree directly.
      visit("/rails/view_components/primer/beta/markdown/#{preview}?theme=#{theme}")
      assert_selector ".preview-wrap", count: copy_count
      assert_selector ".markdown-body", count: copy_count

      driver.browser.page.command("Accessibility.enable")
      nodes = accessibility_nodes
      initial_states = checkbox_states(nodes)
      assert_equal 5 * copy_count, initial_states.size
      assert_equal 2 * copy_count, nodes.values.count { |node| node.dig("role", "value") == "group" }

      all(".preview-wrap").each do |copy|
        groups = copy.all(".markdown-body [role='group']", count: 2)
        assert_task_list(copy, groups[0], "And an unordered task list:", [
          ["Create a sample markdown document", "true"],
          ["Add task lists to it", "false"],
          ["Take a vacation", "false"]
        ], nodes)
        assert_task_list(copy, groups[1], 'And a "mixed" task list:', [
          ["Steal underpants", "false"],
          nil,
          ["Profit!", "false"]
        ], nodes)

        checkbox = copy.find(:checkbox, "Take a vacation", exact: true)
        copy.find("label", exact_text: "Take a vacation").click
        assert_equal initial_states.merge(backend_node_id(checkbox) => "true"), checkbox_states(accessibility_nodes)

        keyboard.type(:space)
        assert_equal initial_states, checkbox_states(accessibility_nodes)
      end
    end

    def assert_task_list(copy, group, name, expected_items, nodes)
      group_node = accessibility_node(group, nodes)
      assert_equal "group", group_node.dig("role", "value")
      assert_equal name, group_node.dig("name", "value")
      assert_browser_label(group_node, copy.find("p", exact_text: name))

      lists = accessible_children(group_node, nodes)
      assert_equal ["list"], lists.map { |node| node.dig("role", "value") }
      native_list = group.find("ul:not([role])")
      assert_equal backend_node_id(native_list), lists.first["backendDOMNodeId"]

      items = accessible_children(lists.first, nodes)
      assert_equal ["listitem"] * 3, items.map { |node| node.dig("role", "value") }
      native_items = native_list.all("li:not([role])", count: 3)
      assert_equal native_items.map { |item| backend_node_id(item) }, items.map { |item| item["backendDOMNodeId"] }

      items.zip(native_items, expected_items).each do |item, native_item, expected|
        children = accessible_children(item, nodes)
        checkboxes = children.select { |node| node.dig("role", "value") == "checkbox" }

        if expected
          assert_equal 1, checkboxes.size
          checkbox = checkboxes.first
          assert_equal expected[0], checkbox.dig("name", "value")
          assert_equal expected[1], accessibility_property(checkbox, "checked").fetch("value")
          assert_equal backend_node_id(native_item.find("input[type='checkbox']")), checkbox["backendDOMNodeId"]
          assert_browser_label(checkbox, native_item.find("label", exact_text: expected[0]))
        else
          assert_empty checkboxes
          text = children.select { |node| node.dig("role", "value") == "StaticText" }
          assert_equal ["?"], text.map { |node| node.dig("name", "value") }
        end
      end
    end

    def accessibility_nodes
      driver.browser.page.command("Accessibility.getFullAXTree").fetch("nodes").index_by { |node| node.fetch("nodeId") }
    end

    def accessibility_node(element, nodes)
      backend_id = backend_node_id(element)
      node = nodes.values.find { |candidate| candidate["backendDOMNodeId"] == backend_id }
      refute_nil node
      refute node["ignored"]
      node
    end

    def accessible_children(node, nodes)
      node.fetch("childIds", []).flat_map do |child_id|
        child = nodes.fetch(child_id)
        child["ignored"] ? accessible_children(child, nodes) : [child]
      end
    end

    def accessibility_property(node, name)
      node.fetch("properties", []).find { |property| property["name"] == name }&.fetch("value")
    end

    def assert_browser_label(node, label)
      # Repeated copies have the same text, so check the browser-resolved label's identity.
      related_nodes = accessibility_property(node, "labelledby")&.fetch("relatedNodes", []) || []
      assert_equal [backend_node_id(label)], related_nodes.map { |related| related.fetch("backendDOMNodeId") }
    end

    def checkbox_states(nodes)
      nodes.values.select { |node| node.dig("role", "value") == "checkbox" }.to_h do |node|
        [node.fetch("backendDOMNodeId"), accessibility_property(node, "checked").fetch("value")]
      end
    end

    def backend_node_id(element)
      element.native.description.fetch("backendNodeId")
    end
  end
end
