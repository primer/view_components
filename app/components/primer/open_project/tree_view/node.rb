# frozen_string_literal: true

module Primer
  module OpenProject
    class TreeView
      # A generic `TreeView` node.
      #
      # This component is part of the <%= link_to_component(Primer::OpenProject::TreeView) %> component and should
      # not be used directly.
      class Node < Primer::Component
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
        # @param current [Boolean] Whether or not this node is the current node. The current node is styled differently than regular nodes and is the first element that receives focus when tabbing to the `TreeView` component.
        # @param select_variant [Symbol] Controls the type of checkbox that appears. <%= one_of(Primer::OpenProject::TreeView::Node::SELECT_VARIANT_OPTIONS) %>
        # @param checked [Boolean | String] The checked state of the node's checkbox. <%= one_of(Primer::OpenProject::TreeView::Node::CHECKED_STATES) %>
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList) %>.
        def initialize(
          path:,
          current: false,
          select_variant: DEFAULT_SELECT_VARIANT,
          checked: DEFAULT_CHECKED_STATE,
          **system_arguments
        )
          @system_arguments = deny_tag_argument(**system_arguments)

          @path = path
          @current = current
          @select_variant = fetch_or_fallback(SELECT_VARIANT_OPTIONS, select_variant, DEFAULT_SELECT_VARIANT)
          @checked = fetch_or_fallback(CHECKED_STATES, checked, DEFAULT_CHECKED_STATE)

          @system_arguments[:tag] = :li
          @system_arguments[:role] = :treeitem
          @system_arguments[:tabindex] = current? ? 0 : -1
          @system_arguments[:classes] = class_names(
            @system_arguments.delete(:classes),
            "TreeViewItem"
          )

          @system_arguments[:aria] = merge_aria(
            @system_arguments, {
              aria: {
                level: level,
                selected: false,
                checked: checked,
                labelledby: content_id
              }
            }
          )

          @system_arguments[:data] = merge_data(
            @system_arguments,
            { data: { path: @path.to_json } }
          )

          return unless current?

          @system_arguments[:aria] = merge_aria(
            @system_arguments,
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
          @system_arguments[:aria] = merge_aria(
            @system_arguments,
            other_arguments
          )

          @system_arguments[:data] = merge_data(
            @system_arguments,
            other_arguments
          )

          @system_arguments.merge!(**other_arguments)
        end

        private

        def before_render
          if leading_visual?
          end

          if leading_action?
            @system_arguments[:data] = merge_data(
              @system_arguments,
              { data: { "has-leading-action": true } }
            )
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
