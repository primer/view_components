# frozen_string_literal: true

module Primer
  module OpenProject
    # @label TreeView
    class TreeViewPreview < ViewComponent::Preview
      # @label Default
      #
      # @snapshot interactive
      # @param expanded [Boolean] toggle
      # @param select_variant [Symbol] select [multiple, none]
      # @param select_strategy [Symbol] select [self, descendants]
      def default(
        expanded: false,
        select_variant: Primer::OpenProject::TreeView::Node::DEFAULT_SELECT_VARIANT,
        select_strategy: Primer::OpenProject::TreeView::SubTreeNode::DEFAULT_SELECT_STRATEGY
      )
        render_with_template(locals: {
          expanded: coerce_bool(expanded),
          select_variant: select_variant.to_sym,
          select_strategy: select_strategy.to_sym
        })
      end

      # @label Playground
      #
      # @param expanded [Boolean] toggle
      # @param select_variant [Symbol] select [multiple, none]
      # @param select_strategy [Symbol] select [self, descendants]
      def playground(
        expanded: false,
        select_variant: Primer::OpenProject::TreeView::Node::DEFAULT_SELECT_VARIANT,
        select_strategy: Primer::OpenProject::TreeView::SubTreeNode::DEFAULT_SELECT_STRATEGY
      )
        render_with_template(locals: {
          expanded: coerce_bool(expanded),
          select_variant: select_variant.to_sym,
          select_strategy: select_strategy.to_sym,
          populate: -> (*args) { populate(*args) }
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

      # @label Leaf node playground
      #
      # @param label [String] text
      # @param leading_visual_icon [Symbol] octicon
      # @param leading_action_icon [Symbol] octicon
      # @param trailing_visual_icon [Symbol] octicon
      # @param select_variant [Symbol] select [multiple, none]
      def leaf_node_playground(
        label: "Leaf node",
        leading_visual_icon: nil,
        leading_action_icon: nil,
        trailing_visual_icon: nil,
        select_variant: Primer::OpenProject::TreeView::Node::DEFAULT_SELECT_VARIANT
      )
        render_with_template(locals: {
          label: label,
          leading_visual_icon: leading_visual_icon,
          leading_action_icon: leading_action_icon,
          trailing_visual_icon: trailing_visual_icon,
          select_variant: select_variant.to_sym
        })
      end

      # @label Links
      #
      # @param expanded [Boolean] toggle
      def links(expanded: false)
        render_with_template(locals: {
          expanded: coerce_bool(expanded)
        })
      end

      # @label Buttons
      #
      def buttons
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
