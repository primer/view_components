# frozen_string_literal: true

module Primer
  module Alpha
    # A `Dialog` is used to remove the user from the main application flow,
    # to confirm actions, ask for disambiguation or to present small forms.
    #
    # @accessibility
    #   - **Dialog Accessible Name**: A dialog should have an accessible name,
    #   so screen readers are aware of the purpose of the dialog when it opens.
    #   Give an accessible name setting `:title`. The accessible name will be
    #   used as the main heading inside the dialog.
    #   - **Dialog unique id**: A dialog should be unique. Give a unique id
    #   setting `:dialog_id`. If no `:dialog_id` is given, a default randomize
    #   hex id is generated.
    #
    #   The combination of both `:title` and `:dialog_id` establishes an
    #   `aria-labelledby` relationship between the title and the unique id of
    #   the dialog.
    class Dialog < Primer::Component
      status :alpha
      audited_at "2022-10-10"

      DEFAULT_SIZE = :medium
      SIZE_MAPPINGS = {
        :small => "Overlay--size-small-portrait",
        :medium_portrait => "Overlay--size-medium-portrait",
        DEFAULT_SIZE => "Overlay--size-medium",
        :large => "Overlay--size-large",
        :xlarge => "Overlay--size-xlarge",
        :auto => "Overlay--size-auto"
      }.freeze
      SIZE_OPTIONS = SIZE_MAPPINGS.keys

      DEFAULT_POSITION = :center
      POSITION_MAPPINGS = {
        DEFAULT_POSITION => "Overlay-backdrop--center",
        :left => "Overlay-backdrop--side Overlay-backdrop--placement-left",
        :right => "Overlay-backdrop--side Overlay-backdrop--placement-right"
      }.freeze
      POSITION_OPTIONS = POSITION_MAPPINGS.keys

      DEFAULT_POSITION_NARROW = :inherit
      POSITION_NARROW_MAPPINGS = {
        DEFAULT_POSITION_NARROW => "",
        :bottom => "Overlay-backdrop--side-whenNarrow Overlay-backdrop--placement-bottom-whenNarrow",
        :fullscreen => "Overlay-backdrop--full-whenNarrow",
        :left => "Overlay-backdrop--side-whenNarrow Overlay-backdrop--placement-left-whenNarrow",
        :right => "Overlay-backdrop--side-whenNarrow Overlay-backdrop--placement-right-whenNarrow"
      }.freeze
      POSITION_NARROW_OPTIONS = POSITION_NARROW_MAPPINGS.keys

      # Optional button to open the dialog.
      #
      # @param system_arguments [Hash] The same arguments as <%= link_to_component(Primer::Beta::Button) %>.
      renders_one :show_button, lambda { |icon: nil, **system_arguments|
        system_arguments[:classes] = class_names(
          system_arguments[:classes]
        )
        system_arguments[:id] = "dialog-show-#{@system_arguments[:id]}"
        system_arguments[:data] = (system_arguments[:data] || {}).merge({ "show-dialog-id": @system_arguments[:id] })
        if icon.present?
          Primer::Beta::IconButton.new(icon: icon, **system_arguments)
        else
          Primer::Beta::Button.new(**system_arguments)
        end
      }

      # Header content.
      #
      # @param show_divider [Boolean] Show a divider between the header and body.
      # @param visually_hide_title [Boolean] Visually hide the `title` while maintaining a label for assistive technologies.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :header, lambda { |show_divider: false, visually_hide_title: @visually_hide_title, **system_arguments|
        Primer::Alpha::Dialog::Header.new(
          id: @id,
          title: @title,
          subtitle: @subtitle,
          show_divider: show_divider,
          visually_hide_title: visually_hide_title,
          **system_arguments
        )
      }

      # Required body content.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :body, "Body"

      # Footer content.
      #
      # @param show_divider [Boolean] Show a divider between the footer and body.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :footer, "Footer"

      # @example Dialog with Cancel and Submit buttons
      #   @description
      #     An ID is provided which enables wiring of the open and close buttons to the dialog.
      #   @code
      #     <%= render(Primer::Alpha::Dialog.new(
      #       title: "Dialog Example",
      #       id: "my-dialog",
      #     )) do |d| %>
      #       <% d.with_show_button { "Show Dialog" } %>
      #       <% d.with_body do %>
      #         <p>Some content</p>
      #       <% end %>
      #       <% d.with_footer do %>
      #         <%= render(Primer::ButtonComponent.new(data: { "close-dialog-id": "my-dialog" })) { "Cancel" } %>
      #         <%= render(Primer::ButtonComponent.new(scheme: :primary)) { "Submit" } %>
      #       <% end %>
      #     <% end %>
      # @param id [String] The id of the dialog.
      # @param title [String] Describes the content of the dialog.
      # @param subtitle [String] Provides additional context for the dialog, also setting the `aria-describedby` attribute.
      # @param size [Symbol] The size of the dialog. <%= one_of(Primer::Alpha::Dialog::SIZE_OPTIONS) %>
      # @param position [Symbol] The position of the dialog. <%= one_of(Primer::Alpha::Dialog::POSITION_OPTIONS) %>
      # @param position_narrow [Symbol] The position of the dialog when narrow. <%= one_of(Primer::Alpha::Dialog::POSITION_NARROW_OPTIONS) %>
      # @param visually_hide_title [Boolean] If true will hide the heading title, while still making it available to Screen Readers.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        title:,
        subtitle: nil,
        size: DEFAULT_SIZE,
        position: DEFAULT_POSITION,
        position_narrow: DEFAULT_POSITION_NARROW,
        visually_hide_title: false,
        id: self.class.generate_id,
        **system_arguments
      )
        @system_arguments = deny_tag_argument(**system_arguments)

        @id = id.to_s
        @title = title
        @subtitle = subtitle
        @size = size
        @position = position
        @position_narrow = position_narrow
        @visually_hide_title = visually_hide_title

        @system_arguments[:tag] = "modal-dialog"
        @system_arguments[:role] = "dialog"
        @system_arguments[:id] = @id
        @system_arguments[:aria] = { modal: true }
        @system_arguments[:aria] = merge_aria(
          @system_arguments, {
            aria: {
              disabled: true,
              describedby: "#{@id}-title #{@id}-description"
            }
          }
        )
        @system_arguments[:classes] = class_names(
          "Overlay",
          "Overlay-whenNarrow",
          SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, @size, DEFAULT_SIZE)],
          "Overlay--motion-scaleFade",
          system_arguments[:classes]
        )
        @backdrop_classes = class_names(
          POSITION_MAPPINGS[fetch_or_fallback(POSITION_OPTIONS, @position, DEFAULT_POSITION)],
          POSITION_NARROW_MAPPINGS[fetch_or_fallback(POSITION_NARROW_MAPPINGS, @position_narrow, DEFAULT_POSITION_NARROW)]
        )
      end

      def before_render
        with_header unless header?
        with_body unless body?
      end
    end
  end
end
