# frozen_string_literal: true

module Primer
  module Alpha
    # Overlay components codify design patterns related to floating surfaces such
    # as dialogs and menus. They are private components intended to be used by
    # specialized components, and mostly contain presentational logic and
    # behavior.
    #
    # @accessibility
    #   - **Overlay Accessible Name**: An overlay should have an accessible name,
    #   so screen readers are aware of the purpose of the Overlay when it opens.
    #   Give an accessible name setting `:title`. The accessible name will be
    #   used as the main heading inside the Overlay.
    #   - **Overlay unique id**: A Overlay should be unique. Give a unique id
    #   setting `:id`. If no `:id` is given, a default randomize hex id is
    #   generated.
    #
    #   The combination of both `:title` and `:id` establishes an
    #   `aria-labelledby` relationship between the title and the unique id
    #   of the Overlay.
    class Overlay < Primer::Component
      DEFAULT_SIZE = :auto
      SIZE_MAPPINGS = {
        DEFAULT_SIZE => "Overlay--size-auto",
        :small => "Overlay--size-small",
        :medium => "Overlay--size-medium",
        :medium_portrait => "Overlay--size-medium-portrait",
        :large => "Overlay--size-large",
        :xlarge => "Overlay--size-xlarge"
      }.freeze
      SIZE_OPTIONS = SIZE_MAPPINGS.keys

      DEFAULT_ANCHOR_ALIGN = :start
      ANCHOR_ALIGN_OPTIONS = [DEFAULT_ANCHOR_ALIGN, :center, :end].freeze

      DEFAULT_ANCHOR_OFFSET = :normal
      ANCHOR_OFFSET_OPTIONS = [DEFAULT_ANCHOR_OFFSET, :spacious].freeze

      DEFAULT_ANCHOR_SIDE = :outside_bottom
      ANCHOR_SIDE_MAPPINGS = {
        :inside_top => "inside-top",
        :inside_bottom => "inside-bottom",
        :inside_left => "inside-left",
        :inside_right => "inside-right",
        :inside_center => "inside-center",
        :outside_top => "outside-top",
        DEFAULT_ANCHOR_SIDE => "outside-bottom",
        :outside_left => "outside-left",
        :outside_right => "outside-right"
      }.freeze
      ANCHOR_SIDE_OPTIONS = ANCHOR_SIDE_MAPPINGS.keys

      DEFAULT_POPOVER = :auto
      POPOVER_OPTIONS = [DEFAULT_POPOVER, :manual].freeze

      ROLE_OPTIONS = [:dialog, :menu].freeze

      # Optional button to open the Overlay.
      #
      # @param system_arguments [Hash] The same arguments as <%= link_to_component(Primer::ButtonComponent) %>.
      renders_one :show_button, lambda { |**system_arguments|
        system_arguments[:classes] = class_names(
          system_arguments[:classes]
        )
        system_arguments[:id] = "overlay-show-#{@system_arguments[:id]}"
        system_arguments["popovertoggletarget"] = @system_arguments[:id]
        system_arguments[:data] = (system_arguments[:data] || {}).merge({ "show-dialog-id": @system_arguments[:id] })
        Primer::Beta::Button.new(**system_arguments)
      }

      # Header content.
      #
      # @param divider [Boolean] Show a divider between the header and body.
      # @param visually_hide_title [Boolean] Visually hide the `title` while maintaining a label for assistive technologies.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :header, lambda { |divider: false, size: :medium, visually_hide_title: @visually_hide_title, **system_arguments|
        Primer::Alpha::Overlay::Header.new(
          id: @id,
          title: @title,
          subtitle: @subtitle,
          size: size,
          divider: divider,
          visually_hide_title: visually_hide_title,
          **system_arguments
        )
      }

      # Required body content.
      #
      # @param padding [Symbol] The padding. <%= one_of(Primer::Alpha::Overlay::PADDING_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :body, lambda { |padding: @padding, **system_arguments|
        Primer::Alpha::Overlay::Body.new(
          padding: padding,
          **system_arguments
        )
      }

      # Footer content.
      #
      # @param show_divider [Boolean] Show a divider between the footer and body.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :footer, "Footer"

      # @example Overlay with Cancel and Submit buttons
      #   @description
      #     An ID is provided which enables wiring of the open and close buttons to the Overlay.
      #   @code
      #     <%= render(Primer::Alpha::Overlay.new(
      #       title: "Overlay Example",
      #       id: "my-Overlay",
      #     )) do |d| %>
      #       <% d.with_show_button { "Show Overlay" } %>
      #       <% d.with_body do %>
      #         <p>Some content</p>
      #       <% end %>
      #     <% end %>
      # @param id [String] The id of the Overlay.
      # @param title [String] Describes the content of the Overlay.
      # @param subtitle [String] Provides dditional context for the Overlay, also setting the `aria-describedby` attribute.
      # @param size [Symbol] The size of the Overlay. <%= one_of(Primer::Alpha::Overlay::SIZE_OPTIONS) %>
      # @param padding [Symbol] The padding given to the Overlay body. <%= one_of(Primer::Alpha::Overlay::PADDING_OPTIONS) %>
      # @param anchor_align [Symbol] The anchor alignment of the Overlay. <%= one_of(Primer::Alpha::Overlay::ANCHOR_ALIGN_OPTIONS) %>
      # @param anchor_side [Symbol] The side to anchor the Overlay to. <%= one_of(Primer::Alpha::Overlay::ANCHOR_SIDE_OPTIONS) %>
      # @param allow_out_of_bounds [Boolean] Allow the Overlay to overflow its container.
      # @param visually_hide_title [Boolean] If true will hide the heading title, while still making it available to Screen Readers.
      # @param role [String] The ARIA role. <%= one_of(Primer::Alpha::Overlay::ROLE_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        title:,
        role:,
        subtitle: nil,
        popover: DEFAULT_POPOVER,
        defaultopen: false,
        size: DEFAULT_SIZE,
        padding: DEFAULT_PADDING,
        anchor: nil,
        anchor_align: DEFAULT_ANCHOR_ALIGN,
        anchor_offset: DEFAULT_ANCHOR_OFFSET,
        anchor_side: DEFAULT_ANCHOR_SIDE,
        allow_out_of_bounds: false,
        visually_hide_title: false,
        id: "overlay-#{(36**3 + rand(36**4)).to_s(36)}",
        **system_arguments
      )
        @system_arguments = deny_tag_argument(**system_arguments)

        @system_arguments[:role] = fetch_or_fallback(ROLE_OPTIONS, role)

        @system_arguments[:id] = id.to_s
        @system_arguments[:classes] = class_names(
          "Overlay",
          SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, DEFAULT_SIZE)],
          "Overlay--motion-scaleFade",
          system_arguments[:classes]
        )
        @system_arguments[:tag] = "anchored-position"
        @system_arguments[:anchor] = anchor || "overlay-show-#{@system_arguments[:id]}"
        @system_arguments[:align] = fetch_or_fallback(ANCHOR_ALIGN_OPTIONS, anchor_align, DEFAULT_ANCHOR_ALIGN)
        @system_arguments[:side] = ANCHOR_SIDE_MAPPINGS[fetch_or_fallback(ANCHOR_SIDE_OPTIONS, anchor_side, DEFAULT_ANCHOR_SIDE)]
        @system_arguments["anchor-offset"] = fetch_or_fallback(ANCHOR_OFFSET_OPTIONS, anchor_offset, DEFAULT_ANCHOR_OFFSET)
        @system_arguments["allow-out-of-bounds"] = true if allow_out_of_bounds
        @id = id.to_s
        @title = title
        @subtitle = subtitle
        @visually_hide_title = visually_hide_title
        @padding = padding

        @system_arguments[:popover] = popover
        @system_arguments[:defaultopen] = "" if defaultopen
        @system_arguments[:aria] ||= {}
        @system_arguments[:aria][:describedby] ||= "#{@id}-description"
      end

      def before_render
        with_header unless header?
        with_body unless body?
      end
    end
  end
end
