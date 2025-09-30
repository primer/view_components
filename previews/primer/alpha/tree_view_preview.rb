# frozen_string_literal: true

module Primer
  module Alpha
    # @label TreeView
    class TreeViewPreview < ViewComponent::Preview
      # @label Default
      #
      # @snapshot interactive
      # @param expanded [Boolean] toggle
      # @param disabled [Boolean] toggle
      # @param select_variant [Symbol] select [multiple, single, none]
      # @param select_strategy [Symbol] select [self, descendants, mixed_descendants]
      def default(
        expanded: false,
        disabled: false,
        select_variant: Primer::Alpha::TreeView::Node::DEFAULT_SELECT_VARIANT,
        select_strategy: Primer::Alpha::TreeView::SubTreeNode::DEFAULT_SELECT_STRATEGY
      )
        render_with_template(locals: {
          expanded: coerce_bool(expanded),
          disabled: coerce_bool(disabled),
          select_variant: select_variant.to_sym,
          select_strategy: select_strategy.to_sym
        })
      end

      # @label Playground
      #
      # @param expanded [Boolean] toggle
      # @param select_variant [Symbol] select [multiple, single, none]
      # @param select_strategy [Symbol] select [self, descendants, mixed_descendants]
      def playground(
        expanded: false,
        select_variant: Primer::Alpha::TreeView::Node::DEFAULT_SELECT_VARIANT,
        select_strategy: Primer::Alpha::TreeView::SubTreeNode::DEFAULT_SELECT_STRATEGY
      )
        render_with_template(locals: {
          expanded: coerce_bool(expanded),
          select_variant: select_variant.to_sym,
          select_strategy: select_strategy.to_sym,
          populate: -> (*args) { populate(*args) }
        })
      end

      # @label Single select
      #
      # @snapshot interactive
      # @param expanded [Boolean] toggle
      # @param disabled [Boolean] toggle
      def single_select(
        expanded: false,
        disabled: false
      )
        render_with_template(locals: {
          expanded: coerce_bool(expanded),
          disabled: coerce_bool(disabled),
          select_variant: :single,
        })
      end

      # @label Multi select
      #
      # @snapshot interactive
      # @param expanded [Boolean] toggle
      # @param disabled [Boolean] toggle
      def multi_select(
        expanded: false,
        disabled: false
      )
        render_with_template(locals: {
          expanded: coerce_bool(expanded),
          disabled: coerce_bool(disabled),
          select_variant: :multiple,
        })
      end

      # @label Empty
      #
      # @snapshot interactive
      def empty
      end

      # @label Loading failure
      #
      # @snapshot interactive
      def loading_failure
      end

      # @label Loading spinner
      #
      # @snapshot interactive
      # @param simulate_failure [Boolean] toggle
      # @param simulate_empty [Boolean] toggle
      def loading_spinner(simulate_failure: false, simulate_empty: false)
        render_with_template(locals: {
          simulate_failure: coerce_bool(simulate_failure),
          simulate_empty: coerce_bool(simulate_empty),
        })
      end

      # @label Loading skeleton
      #
      # @snapshot interactive
      # @param simulate_failure [Boolean] toggle
      # @param simulate_empty [Boolean] toggle
      def loading_skeleton(simulate_failure: false, simulate_empty: false)
        render_with_template(locals: {
          simulate_failure: coerce_bool(simulate_failure),
          simulate_empty: coerce_bool(simulate_empty)
        })
      end

      # @label Async alpha
      #
      # @param action_menu_expanded [Boolean] toggle
      def async_alpha(action_menu_expanded: false)
        render_with_template(locals: {
          action_menu_expanded: coerce_bool(action_menu_expanded)
        })
      end

      # @label Leaf node playground
      #
      # @param label [String] text
      # @param leading_visual_icon [Symbol] octicon
      # @param leading_action_icon [Symbol] octicon
      # @param trailing_visual_icon [Symbol] octicon
      # @param select_variant [Symbol] select [multiple, single, none]
      # @param disabled [Boolean] toggle
      def leaf_node_playground(
        label: "Leaf node",
        leading_visual_icon: nil,
        leading_action_icon: nil,
        trailing_visual_icon: nil,
        select_variant: Primer::Alpha::TreeView::Node::DEFAULT_SELECT_VARIANT,
        disabled: false
      )
        render_with_template(locals: {
          label: label,
          leading_visual_icon: leading_visual_icon,
          leading_action_icon: leading_action_icon,
          trailing_visual_icon: trailing_visual_icon,
          select_variant: select_variant.to_sym,
          disabled: disabled
        })
      end

      # @label Links
      #
      # @param expanded [Boolean] toggle
      # @param disabled [Boolean] toggle
      def links(expanded: false, disabled: false)
        render_with_template(locals: {
          expanded: coerce_bool(expanded),
          disabled: coerce_bool(disabled)
        })
      end

      # @label Buttons
      #
      # @param expanded [Boolean] toggle
      # @param disabled [Boolean] toggle
      def buttons(expanded: false, disabled: false)
        render_with_template(locals: {
          expanded: coerce_bool(expanded),
          disabled: coerce_bool(disabled)
        })
      end

      # @label Auto expansion
      #
      def auto_expansion
        render(Primer::Alpha::TreeView.new) do |tree|
          tree.with_sub_tree(label: "Level 1") do |level1|
            level1.with_sub_tree(label: "Level 2") do |level2|
              # marking this node as expanded should automatically expand all ancestors
              level2.with_sub_tree(label: "Level 3", expanded: true) do |level3|
                level3.with_leaf(label: "Level 4")
              end
            end
          end
        end
      end

      # @label Form input
      #
      # @param select_variant [Symbol] select [multiple, single]
      # @param expanded [Boolean] toggle
      def form_input(select_variant: :multiple, expanded: true)
        render_with_template(locals: {
          select_variant: select_variant.to_sym,
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

      def populate(node, data, node_arguments)
        return unless data

        entries = (
          data.fetch("children", {}).keys.map { |label, idx| [label, :directory] } +
            data.fetch("files", []).map { |label| [label, :file] }
        )

        entries.sort_by!(&:first)

        entries.each do |label, kind, idx|
          case kind
          when :directory
            node.with_sub_tree(label: label, **node_arguments) do |sub_tree|
              sub_tree.with_leading_visual_icons do |icons|
                icons.with_expanded_icon(icon: :"file-directory-open-fill", color: :accent)
                icons.with_collapsed_icon(icon: :"file-directory-fill", color: :accent)
              end

              populate(sub_tree, data["children"][label], node_arguments)
            end
          when :file
            node.with_leaf(label: label, **node_arguments) do |leaf|
              leaf.with_leading_visual_icon(icon: :file)
            end
          end
        end
      end
    end
  end
end
