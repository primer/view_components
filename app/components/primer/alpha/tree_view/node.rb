# frozen_string_literal: true

module Primer
  module Alpha
    class TreeView
      # A generic `TreeView` node.
      #
      # This component is part of the <%= link_to_component(Primer::Alpha::TreeView) %> component and should
      # not be used directly.
      class Node < Primer::Component
        DEFAULT_NODE_VARIANT = Primer::Alpha::TreeView::DEFAULT_NODE_VARIANT
        NODE_VARIANT_TAG_MAP = { DEFAULT_NODE_VARIANT => :div, :button => :button, :anchor => :a }.freeze
        NODE_VARIANT_TAG_OPTIONS = NODE_VARIANT_TAG_MAP.keys.freeze

        # Generic leading action slot
        renders_one :leading_action

        # Generic leading visual slot
        renders_one :leading_visual

        # Generic trailing visual slot
        renders_one :trailing_visual

        # Generic toggle button slot
        renders_one :toggle

        # Generic text content slot (for node's label)
        renders_one :text_content

        # Wether or not this node is the current node.
        #
        # @return [Boolean]
        attr_reader :current
        alias current? current

        # This node's checked state.
        #
        # @return [String]
        attr_reader :checked

        # This node's select variant (i.e. check box variant).
        #
        # @return [Symbol]
        attr_reader :select_variant

        # This node's variant, eg. `:button`, `:div`, etc.
        #
        # @return [Symbol]
        attr_reader :node_variant

        DEFAULT_SELECT_VARIANT = :none
        SELECT_VARIANT_OPTIONS = [
          :multiple,
          DEFAULT_SELECT_VARIANT
        ].freeze

        DEFAULT_CHECKED_STATE = false
        CHECKED_STATES = [
          DEFAULT_CHECKED_STATE,
          true,
          "mixed"
        ]

        # @param path [Array<String>] The node's "path," i.e. this node's label and the labels of all its ancestors. This node should be reachable by traversing the tree following this path.
        # @param node_variant [Symbol] The node variant to use for the node's content, i.e. the `:button` or `:div`. <%= one_of(Primer::Alpha::TreeView::NODE_VARIANT_OPTIONS) %>
        # @param href [String] The URL to use as the `href` attribute for this node. If set to a truthy value, the `tag:` parameter is ignored and assumed to be `:a`.
        # @param current [Boolean] Whether or not this node is the current node. The current node is styled differently than regular nodes and is the first element that receives focus when tabbing to the `TreeView` component.
        # @param select_variant [Symbol] Controls the type of checkbox that appears. <%= one_of(Primer::Alpha::TreeView::Node::SELECT_VARIANT_OPTIONS) %>
        # @param checked [Boolean | String] The checked state of the node's checkbox. <%= one_of(Primer::Alpha::TreeView::Node::CHECKED_STATES) %>
        # @param content_arguments [Hash] Arguments attached to the node's content, i.e the `<button>` or `<a>` element. <%= link_to_system_arguments_docs %>
        def initialize(
          path:,
          node_variant:,
          href: nil,
          current: false,
          select_variant: DEFAULT_SELECT_VARIANT,
          checked: DEFAULT_CHECKED_STATE,
          **content_arguments
        )
          @system_arguments = {
            tag: :li,
            role: :none,
            classes: "TreeViewItem"
          }

          @content_arguments = content_arguments

          @path = path
          @current = current
          @select_variant = fetch_or_fallback(SELECT_VARIANT_OPTIONS, select_variant, DEFAULT_SELECT_VARIANT)
          @checked = fetch_or_fallback(CHECKED_STATES, checked, DEFAULT_CHECKED_STATE)
          @node_variant = fetch_or_fallback(NODE_VARIANT_TAG_OPTIONS, node_variant, DEFAULT_NODE_VARIANT)

          @content_arguments[:tag] = NODE_VARIANT_TAG_MAP[@node_variant]
          @content_arguments[:href] = href if href
          @content_arguments[:id] = content_id
          @content_arguments[:role] = :treeitem
          @content_arguments[:tabindex] = current? ? 0 : -1
          @content_arguments[:classes] = class_names(
            @content_arguments.delete(:classes),
            "TreeViewItemContent"
          )

          @content_arguments[:aria] = merge_aria(
            @content_arguments, {
              aria: {
                level: level,
                selected: false,
                checked: checked,
                labelledby: content_id
              }
            }
          )

          @content_arguments[:data] = merge_data(
            @content_arguments,
            { data: { path: @path.to_json } }
          )

          return unless current?

          @content_arguments[:aria] = merge_aria(
            @content_arguments,
            { aria: { current: true } }
          )
        end

        # The numeric depth of this node.
        #
        # @return [Integer] This node's depth.
        def level
          @level ||= @path.size
        end

        # Merges the given arguments into the current hash of system arguments provided when the component was
        # initially constructed. This method can be used to add additional arguments just before rendering.
        #
        # @param other_arguments [Hash] The other hash of system arguments to merge into the current one.
        def merge_system_arguments!(**other_arguments)
          @content_arguments[:aria] = merge_aria(
            @content_arguments,
            other_arguments
          )

          @content_arguments[:data] = merge_data(
            @content_arguments,
            other_arguments
          )

          @content_arguments.merge!(**other_arguments)
        end

        private

        def before_render
          if leading_action?
            @content_arguments[:data] = merge_data(
              @content_arguments,
              { data: { "has-leading-action": true } }
            )
          end

          if select_variant != :none && node_variant != :div
            raise ArgumentError, "TreeView nodes do not support select variants for tags other than :div."
          end
        end

        def content_id
          @content_id ||= "#{base_id}-content"
        end

        def base_id
          @base_id ||= self.class.generate_id
        end
      end
    end
  end
end
