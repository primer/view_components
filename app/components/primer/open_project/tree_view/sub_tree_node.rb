# frozen_string_literal: true

module Primer
  module OpenProject
    class TreeView
      # A `TreeView` sub-tree node.
      #
      # This component is part of the <%= link_to_component(Primer::OpenProject::TreeView) %> component and should
      # not be used directly.
      class SubTreeNode < Primer::Component
        DEFAULT_SELECT_STRATEGY = :descendants
        SELECT_STRATEGIES = [
          :self,
          DEFAULT_SELECT_STRATEGY
        ]

        # @!parse
        #   # Adds a leading visual icon rendered to the left of the node's label.
        #   #
        #   # @param label [String] A label describing the visual, displayed only to screen readers.
        #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::OpenProject::TreeView::Icon) %>.
        #   def with_leading_visual_icon(label: nil, **system_arguments, &block)
        #   end

        # @!parse
        #   # Adds a pair of leading visual icon rendered to the left of the node's label.
        #   #
        #   # @param label [String] A label describing the visual, displayed only to screen readers.
        #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::OpenProject::TreeView::IconPair) %>.
        #   def with_leading_visual_icons(label: nil, **system_arguments, &block)
        #   end

        renders_one :leading_visual, types: {
          icon: lambda { |label: nil, **system_arguments|
            merge_system_arguments!(
              aria: { describedby: leading_visual_label_id }
            )

            Visual.new(
              id: leading_visual_label_id,
              label: label,
              visual: Icon.new(**system_arguments)
            )
          },

          icons: lambda { |label: nil, **system_arguments|
            merge_system_arguments!(
              aria: { describedby: leading_visual_label_id }
            )

            system_arguments[:data] = merge_data(
              system_arguments,
              { data: { target: "tree-view-sub-tree-node.iconPair" } }
            )

            Visual.new(
              id: leading_visual_label_id,
              label: label,
              visual: IconPair.new(
                **system_arguments,
                expanded: @sub_tree.expanded?,
              )
            )
          }
        }

        # @!parse
        #   # Adds a leading action rendered to the left of the node's label and any leading visuals or checkboxes.
        #   #
        #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Beta::IconButton) %>.
        #   def with_leading_action_button(**system_arguments, &block)
        #   end

        renders_one :leading_action, types: {
          button: lambda { |**system_arguments|
            LeadingAction.new(
              action: Primer::Beta::IconButton.new(
                scheme: :invisible,
                **system_arguments
              )
            )
          }
        }

        # @!parse
        #   # Adds a trailing visual icon rendered to the right of the node's label.
        #   #
        #   # @param label [String] A label describing the visual, displayed only to screen readers.
        #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::OpenProject::TreeView::Icon) %>.
        #   def with_trailing_visual_icon(label: nil, **system_arguments, &block)
        #   end

        renders_one :trailing_visual, types: {
          icon: lambda { |**system_arguments|
            label = system_arguments.delete(:label)

            Visual.new(
              id: nil,
              visual: Icon.new(**system_arguments),
              label: label
            )
          }
        }

        delegate :with_leaf, :with_sub_tree, :with_loading_spinner, :with_loading_skeleton, :nodes, to: :@sub_tree
        delegate :current?, :merge_system_arguments!, to: :@node

        # @param label [String] The node's label, i.e. it's textual content.
        # @param path [Array<String>] The node's "path," i.e. this node's label and the labels of all its ancestors. This node should be reachable by traversing the tree following this path.
        # @param expanded [Boolean] Whether or not this sub-tree should be rendered expanded.
        # @param select_strategy [Symbol] What should happen when this sub-tree node is checked. <%= one_of(Primer::OpenProject::TreeView::SubTreeNode::SELECT_STRATEGIES) %>
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::OpenProject::TreeView::Node) %>.
        def initialize(label:, path:, expanded: false, select_strategy: DEFAULT_SELECT_STRATEGY, **system_arguments)
          @label = label
          @system_arguments = system_arguments
          @select_strategy = fetch_or_fallback(SELECT_STRATEGIES, select_strategy, DEFAULT_SELECT_STRATEGY)

          @system_arguments[:aria] = merge_aria(
            @system_arguments,
            { aria: { expanded: expanded } }
          )

          @system_arguments[:data] = merge_data(
            @system_arguments, {
              data: {
                target: "tree-view-sub-tree-node.node",
                "node-type": "sub-tree"
              }
            }
          )

          sub_tree_arguments = @system_arguments.delete(:sub_tree_arguments) || {}

          @sub_tree = SubTree.new(
            expanded: expanded,
            path: path,
            **sub_tree_arguments
          )

          @node = Primer::OpenProject::TreeView::Node.new(**@system_arguments, path: @sub_tree.path)

          return if @node.select_variant == :none

          @node.merge_system_arguments!(
            data: {
              "select-strategy": @select_strategy
            }
          )
        end

        def render_in(*args, &block)
          super.tap do
            # check this _after_ rendering so @sub_tree's slots are defined
            if @node.select_variant != :none && @sub_tree.defer?
              raise ArgumentError, "TreeView does not currently support select variants for sub-trees loaded asynchronously."
            end
          end
        end

        private

        def base_id
          @base_id ||= self.class.generate_id
        end

        def leading_visual_label_id
          @leading_visual_id ||= "#{base_id}-leading-visual-label"
        end
      end
    end
  end
end
