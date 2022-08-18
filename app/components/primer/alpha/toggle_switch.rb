# frozen_string_literal: true

module Primer
  module Alpha
    # The ToggleSwitch component is a button that toggles between two boolean states. It is meant to be used for
    # settings that should cause an immediate update.
    class ToggleSwitch < Primer::Component
      warn_on_deprecated_slot_setter

      SIZE_DEFAULT = :medium
      SIZE_MAPPINGS = {
        SIZE_DEFAULT => nil,
        :small => "ToggleSwitch--small"
      }.freeze
      SIZE_OPTIONS = SIZE_MAPPINGS.keys.freeze

      STATUS_LABEL_POSITION_DEFAULT = :start
      STATUS_LABEL_POSITION_MAPPINGS = {
        STATUS_LABEL_POSITION_DEFAULT => nil,
        :end => "ToggleSwitch--statusAtEnd"
      }.freeze
      STATUS_LABEL_POSITION_OPTIONS = STATUS_LABEL_POSITION_MAPPINGS.keys.freeze

      # @example Default
      #
      #   @code
      #     <%= render(Primer::Experimental::ToggleSwitch.new(src: "/foo")) %>
      #
      # @example Checked
      #
      #   @code
      #     <%= render(Primer::Experimental::ToggleSwitch.new(src: "/foo", checked: true)) %>
      #
      # @example Disabled
      #
      #   @code
      #     <%= render(Primer::Experimental::ToggleSwitch.new(src: "/foo", enabled: false)) %>
      #
      # @example Checked and Disabled
      #
      #   @code
      #     <%= render(Primer::Experimental::ToggleSwitch.new(src: "/foo", checked: true, enabled: false)) %>
      #
      # @example Small
      #
      #   @code
      #     <%= render(Primer::Experimental::ToggleSwitch.new(src: "/foo", size: :small)) %>
      #
      # @example With status label positioned at the end
      #
      #   @code
      #     <%= render(Primer::Experimental::ToggleSwitch.new(src: "/foo", status_label_position: :end)) %>
      #
      # @param src [String] The URL to POST to when the toggle switch is toggled. If `nil`, the toggle switch will not make a request.
      # @param csrf_token [String] A CSRF token that will be sent to the server as "authenticity_token" when the toggle switch is toggled.
      # @param checked [Boolean] Whether the toggle switch is on or off.
      # @param enabled [Boolean] Whether or not the toggle switch responds to user input.
      # @param size [Symbol] What size toggle switch to render. <%= one_of(Primer::Experimental::ToggleSwitch::STATUS_LABEL_POSITION_OPTIONS) %>
      # @param status_label_position [Symbol] Which side of the toggle switch to render the status label. <%= one_of(Primer::Experimental::ToggleSwitch::SIZE_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(src: nil, csrf_token: nil, checked: false, enabled: true, size: SIZE_DEFAULT, status_label_position: STATUS_LABEL_POSITION_DEFAULT, **system_arguments)
        @src = src
        @csrf_token = csrf_token
        @checked = checked
        @enabled = enabled
        @system_arguments = system_arguments

        @size = fetch_or_fallback(SIZE_OPTIONS, size, SIZE_DEFAULT)
        @status_label_position = fetch_or_fallback(
          STATUS_LABEL_POSITION_OPTIONS, status_label_position, STATUS_LABEL_POSITION_DEFAULT
        )

        @system_arguments[:classes] = class_names(
          @system_arguments.delete(:classes),
          "ToggleSwitch",
          on? ? "ToggleSwitch--checked" : nil,
          enabled? ? nil : "ToggleSwitch--disabled",
          STATUS_LABEL_POSITION_MAPPINGS[@status_label_position],
          SIZE_MAPPINGS[@size]
        )

        @system_arguments[:src] = @src if @src

        if @src && @csrf_token
          @system_arguments[:data] ||= {}
          @system_arguments[:data][:csrf] = @csrf_token
        end
      end

      def on?
        @checked
      end

      def enabled?
        @enabled
      end

      def disabled?
        !enabled?
      end
    end
  end
end
