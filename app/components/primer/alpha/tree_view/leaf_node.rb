# frozen_string_literal: true

module Primer
  module Alpha
    class TreeView
      # A `TreeView` leaf node.
      #
      # This component is part of the <%= link_to_component(Primer::Alpha::TreeView) %> component and should
      # not be used directly.
      class LeafNode < Primer::Component
        # @!parse
        #   # Adds a leading visual icon rendered to the left of the node's label.
        #   #
        #   # @param label [String] A label describing the visual, displayed only to screen readers.
        #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::TreeView::Icon) %>.
        #   def with_leading_visual_icon(label: nil, **system_arguments, &block)
        #   end

        renders_one :leading_visual, types: {
          icon: lambda { |label: nil, **system_arguments|
            merge_system_arguments!(
              aria: { describedby: leading_visual_label_id }
            )

            Visual.new(
              id: leading_visual_label_id,
              visual: Icon.new(**system_arguments),
              label: label
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
        #   # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::TreeView::Icon) %>.
        #   def with_trailing_visual_icon(label: nil, **system_arguments, &block)
        #   end

        renders_one :trailing_visual, types: {
          icon: lambda { |label: nil, **system_arguments|
            Visual.new(
              id: nil,
              visual: Icon.new(**system_arguments),
              label: label
            )
          }
        }

        delegate :current?, :merge_system_arguments!, to: :@node

        # @param label [String] The node's label, i.e. it's textual content.
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::TreeView::Node) %>.
        def initialize(label:, **system_arguments)
          @label = label
          @system_arguments = system_arguments
          @system_arguments[:data] = merge_data(
            @system_arguments,
            data: { "node-type": "leaf" }
          )

          @node = Primer::Alpha::TreeView::Node.new(**@system_arguments)
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
