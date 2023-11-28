# frozen_string_literal: true

module Primer
  module OpenProject
    # `InputGroup` is composed of a text field input with a trailing action
    class InputGroup < Primer::Component
      status :open_project

      DEFAULT_INPUT_WIDTH = :auto
      INPUT_WIDTH_MAPPINGS = {
        DEFAULT_INPUT_WIDTH => "InputGroup-input-width--auto",
        :small => "InputGroup-input-width--small",
        :medium => "InputGroup-input-width--medium",
        :large => "InputGroup-input-width--large",
        :xlarge => "InputGroup-input-width--xlarge",
        :xxlarge => "InputGroup-input-width--xxlarge"
      }.freeze
      INPUT_WIDTH_OPTIONS = INPUT_WIDTH_MAPPINGS.keys

      # A component that will render to the right of the label.
      #
      # To render a clipboardCopyButton, call the `with_trailing_action_clipboard_copy_button` method, which accepts the arguments accepted by <%= link_to_component(Primer::Beta::ClipboardCopyButton) %>.
      #
      # To render an iconButton, call the `with_trailing_action_icon` method, which accepts the arguments accepted by <%= link_to_component(Primer::Beta::Octicon) %>.
      renders_one :trailing_action, types: {
        clipboard_copy_button: lambda { |**system_arguments, &block|
          system_arguments[:classes] = class_names(
            system_arguments[:classes],
            "rounded-left-0 border-left-0"
          )
          Primer::Beta::ClipboardCopyButton.new(**system_arguments, &block)
        },
        icon: lambda { |icon: nil, **system_arguments, &block|
          system_arguments[:classes] = class_names(
            system_arguments[:classes],
            "rounded-left-0 border-left-0"
          )
          Primer::Beta::IconButton.new(icon: icon, **system_arguments, &block)
        }
      }

      # Input that is the central part of the input group
      #
      # Since the central use case of this component is a copyClipboard Button next to the input, it is readonly by default
      #
      # @param readonly [Boolean] Shall the text field be editable.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :text_input, lambda { |readonly: true, **system_arguments|
        deny_single_argument(:input_width, "Set the `input_width` on the `InputGroup`", **system_arguments)
        system_arguments[:input_width] = @system_arguments[:input_width]

        system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "rounded-right-0"
        )

        if readonly
          system_arguments[:readonly] = readonly
          system_arguments[:aria] = merge_aria(
            system_arguments,
            { aria: { readonly: "true" } }
          )
        end

        Primer::Alpha::TextField.new(**system_arguments)
      }

      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
        @system_arguments[:display] = :flex
        @system_arguments[:align_items] = :flex_end

        @system_arguments[:input_width] = fetch_or_fallback(
          Primer::OpenProject::InputGroup::INPUT_WIDTH_OPTIONS,
          @system_arguments[:input_width] || Primer::OpenProject::InputGroup::DEFAULT_INPUT_WIDTH,
          Primer::OpenProject::InputGroup::DEFAULT_INPUT_WIDTH
        )

        system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "InputGroup",
          INPUT_WIDTH_MAPPINGS[@system_arguments[:input_width]]
        )
      end

      def render?
        text_input? && trailing_action?
      end
    end
  end
end
