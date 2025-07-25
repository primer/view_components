# frozen_string_literal: true

module Primer
  module Alpha
    class TreeView
      # A `TreeView` sub-tree.
      #
      # This component is part of the <%= link_to_component(Primer::Alpha::TreeView) %> component and should
      # not be used directly.
      class SubTree < Primer::Component
        # @!parse
        #   # Adds an leaf node to the tree. Leaf nodes are nodes that do not have children.
        #   #
        #   # @param component_klass [Class] The class to use instead of the default <%= link_to_component(Primer::Alpha::TreeView::LeafNode) %>
        #   # @param system_arguments [Hash] These arguments are forwarded to <%= link_to_component(Primer::Alpha::TreeView::LeafNode) %>, or whatever class is passed as the `component_klass` argument.
        #   def with_leaf(**system_arguments, &block)
        #   end

        # @!parse
        #   # Adds a sub-tree node to the tree. Sub-trees are nodes that have children, which can be both leaf nodes and other sub-trees.
        #   #
        #   # @param component_klass [Class] The class to use instead of the default <%= link_to_component(Primer::Alpha::TreeView::SubTreeNode) %>
        #   # @param system_arguments [Hash] These arguments are forwarded to <%= link_to_component(Primer::Alpha::TreeView::SubTreeNode) %>, or whatever class is passed as the `component_klass` argument.
        #   def with_sub_tree(**system_arguments, &block)
        #   end

        renders_many :nodes, types: {
          leaf: {
            renders: lambda { |component_klass: LeafNode, label:, **system_arguments|
              component_klass.new(
                **system_arguments,
                node_variant: node_variant,
                path: [*path, label],
                label: label
              )
            },

            as: :leaf
          },

          sub_tree: {
            renders: lambda { |component_klass: SubTreeNode, label:, **system_arguments|
              component_klass.new(
                **system_arguments,
                node_variant: node_variant,
                path: [*path, label],
                label: label
              )
            },

            as: :sub_tree
          }
        }

        # @!parse
        #   # Adds a loader to this sub-tree that displays a spinner animation while nodes are fetched from the server.
        #   #
        #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::TreeView::SpinnerLoader) %>.
        #   def with_loading_spinner(**system_arguments, &block)
        #   end

        # @!parse
        #   # Adds a loader to this sub-tree that displays a skeleton animation while nodes are fetched from the server.
        #   #
        #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::TreeView::SkeletonLoader) %>.
        #   def with_loading_spinner(**system_arguments, &block)
        #   end

        renders_one :loader, types: {
          spinner: {
            renders: lambda { |**system_arguments|
              SpinnerLoader.new(**system_arguments, path: path)
            },

            as: :loading_spinner
          },

          skeleton: {
            renders: lambda { |**system_arguments|
              SkeletonLoader.new(**system_arguments, path: path)
            },

            as: :loading_skeleton
          }
        }

        # The message to display if this sub-tree contains no children.
        renders_one :no_items_message

        delegate :path, :expanded?, to: :@container

        attr_reader :node_variant

        # @param node_variant [Symbol] The variant to use for this node. <%= one_of(Primer::Alpha::TreeView::NODE_VARIANT_OPTIONS) %>
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::TreeView::SubTreeContainer) %>.
        def initialize(node_variant:, **system_arguments)
          @node_variant = node_variant

          system_arguments[:data] = merge_data(
            system_arguments,
            { data: { target: "tree-view-sub-tree-node.subTree" } }
          )

          @container = SubTreeContainer.new(**system_arguments)
        end

        def defer?
          loader?
        end
      end
    end
  end
end
