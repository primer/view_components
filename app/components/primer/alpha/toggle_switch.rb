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

      # @param src [String] The URL to POST to when the toggle switch is toggled. If `nil`, the toggle switch will not make any requests.
      # @param csrf_token [String] A CSRF token that will be sent to the server as "authenticity_token" when the toggle switch is toggled. Unused if `src` is `nil`.
      # @param checked [Boolean] Whether the toggle switch is on or off.
      # @param enabled [Boolean] Whether or not the toggle switch responds to user input.
      # @param size [Symbol] What size toggle switch to render. <%= one_of(Primer::Alpha::ToggleSwitch::SIZE_OPTIONS) %>
      # @param status_label_position [Symbol] Which side of the toggle switch to render the status label. <%= one_of(Primer::Alpha::ToggleSwitch::STATUS_LABEL_POSITION_OPTIONS) %>
      # @param turbo [Boolean] Whether or not to request a turbo stream and render the response as such.
      # @param autofocus [Boolean] Whether switch should be autofocused when rendered.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        src: nil,
        csrf_token: nil,
        checked: false,
        enabled: true,
        size: SIZE_DEFAULT,
        status_label_position: STATUS_LABEL_POSITION_DEFAULT,
        turbo: false,
        autofocus: nil,
        **system_arguments
      )
        @src = src
        @csrf_token = csrf_token
        @checked = checked
        @enabled = enabled
        @turbo = turbo
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

        @button_arguments = {
          aria: merge_aria(
            @system_arguments,
            aria: { pressed: on? }
          )
        }
        @button_arguments[:autofocus] = true if autofocus

        @system_arguments[:src] = @src if @src
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

      private

      def before_render
        @csrf_token ||= view_context.form_authenticity_token(
          form_options: {
            method: :post,
            action: @src
          }
        )

        @system_arguments[:data] = merge_data(
          @system_arguments,
          { data: { csrf: @csrf_token } }
        )
        @system_arguments[:data][:turbo] = true if @turbo
      end
    end
  end
end
