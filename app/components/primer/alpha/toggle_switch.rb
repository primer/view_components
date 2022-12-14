# frozen_string_literal: true

module Primer
  module Alpha
    # The ToggleSwitch component is a button that toggles between two boolean states. It is meant to be used for
    # settings that should cause an immediate update. If configured with a "src" attribute, the component will
    # make a POST request containing data of the form "value: 0 | 1".
    class ToggleSwitch < Primer::Component
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
      #   <%= render(Primer::Alpha::ToggleSwitch.new(src: "/foo")) %>
      #
      # @example Checked
      #   <%= render(Primer::Alpha::ToggleSwitch.new(src: "/foo", checked: true)) %>
      #
      # @example Disabled
      #   <%= render(Primer::Alpha::ToggleSwitch.new(src: "/foo", enabled: false)) %>
      #
      # @example Checked and Disabled
      #   <%= render(Primer::Alpha::ToggleSwitch.new(src: "/foo", checked: true, enabled: false)) %>
      #
      # @example Small
      #   <%= render(Primer::Alpha::ToggleSwitch.new(src: "/foo", size: :small)) %>
      #
      # @example With status label positioned at the end
      #   <%= render(Primer::Alpha::ToggleSwitch.new(src: "/foo", status_label_position: :end)) %>
      #
      # @param src [String] The URL to POST to when the toggle switch is toggled. If `nil`, the toggle switch will not make any requests.
      # @param csrf_token [String] A CSRF token that will be sent to the server as "authenticity_token" when the toggle switch is toggled. Unused if `src` is `nil`.
      # @param checked [Boolean] Whether the toggle switch is on or off.
      # @param enabled [Boolean] Whether or not the toggle switch responds to user input.
      # @param size [Symbol] What size toggle switch to render. <%= one_of(Primer::Alpha::ToggleSwitch::STATUS_LABEL_POSITION_OPTIONS) %>
      # @param status_label_position [Symbol] Which side of the toggle switch to render the status label. <%= one_of(Primer::Alpha::ToggleSwitch::SIZE_OPTIONS) %>
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

        return unless @src && @csrf_token

        @system_arguments[:csrf] = @csrf_token
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
