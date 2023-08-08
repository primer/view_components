# frozen_string_literal: true

module Primer
  module Beta
    # Use `Blankslate` when there is a lack of content within a page or section. Use as placeholder to tell users why something isn't there.
    #
    # @accessibility
    #   - The blankslate uses a semantic heading that must be set at the appropriate level based on the hierarchy of the page.
    #   - All blankslate visuals have been programmed as decorative images, using `aria-hidden=”true”` and `img alt=””`,  which will hide the visual from screen reader users.
    #   - The blankslate supports a primary and secondary action. Both actions have been built as semantic links with primary and secondary styling.
    #   - `secondary_action` text should be meaningful out of context and clearly describe the destination. Avoid using vague text like, "Learn more" or "Click here".
    #   - The blankslate can leverage the spinner component, which will communicate to screen reader users that the content is still loading.
    class Blankslate < Primer::Component
      status :beta

      VISUAL_OPTIONS = %i[icon spinner image].freeze

      # Optional visual.
      #
      # Use:
      #
      # - `visual_icon` for an <%= link_to_component(Primer::Beta::Octicon) %>.
      # - `visual_image` for an <%= link_to_component(Primer::Alpha::Image) %>.
      # - `visual_spinner` for a <%= link_to_component(Primer::Beta::Spinner) %>.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :visual, types: {
        icon: lambda { |**system_arguments|
          system_arguments[:size] ||= :medium
          system_arguments[:classes] = class_names("blankslate-icon", system_arguments[:classes])

          Primer::Beta::Octicon.new(**system_arguments)
        },
        spinner: lambda { |**system_arguments|
          system_arguments[:classes] = class_names("blankslate-image", system_arguments[:classes])

          Primer::Beta::Spinner.new(**system_arguments)
        },
        image: lambda { |**system_arguments|
          system_arguments[:size] = "56x56"
          system_arguments[:classes] = class_names("blankslate-image", system_arguments[:classes])

          Primer::Alpha::Image.new(**system_arguments)
        }
      }

      # Required heading.
      #
      # @param tag [String]  <%= one_of(Primer::Beta::Heading::TAG_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :heading, lambda { |tag:, **system_arguments|
        deny_tag_argument(**system_arguments)
        system_arguments[:tag] = tag
        system_arguments[:classes] = class_names("blankslate-heading", system_arguments[:classes])

        Primer::Beta::Heading.new(**system_arguments)
      }

      # Optional description.
      #
      # - The description should always be informative and actionable.
      # - Don't use phrases like "You can".
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :description, lambda { |**system_arguments|
        deny_tag_argument(**system_arguments)
        system_arguments[:tag] = :p

        Primer::BaseComponent.new(**system_arguments)
      }

      # Optional primary action
      #
      # The `primary_action` slot renders an anchor link which is visually styled as a button to provide more emphasis to the
      # Blankslate's primary action.
      #
      # @param href [String] URL to be used for the primary action.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :primary_action, lambda { |href:, **system_arguments|
        deny_tag_argument(**system_arguments)
        system_arguments[:tag] = :a
        system_arguments[:href] = href
        system_arguments[:size] = :medium
        system_arguments[:scheme] ||= :primary

        Primer::Beta::Button.new(**system_arguments)
      }

      # Optional secondary action
      #
      # The `secondary_action` slot renders a normal anchor link, which can be used to redirect the user to additional information
      # (e.g. Help documentation).
      #
      # @param href [String] URL to be used for the secondary action.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :secondary_action, lambda { |href:, **system_arguments|
        system_arguments[:href] = href

        Primer::Beta::Link.new(**system_arguments)
      }

      # @param narrow [Boolean] Adds a maximum width of `485px` to the Blankslate.
      # @param spacious [Boolean] Increases the padding from `32px` to `80px 40px`.
      # @param border [Boolean] Adds a border around the Blankslate.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(narrow: false, spacious: false, border: false, **system_arguments)
        @border = border
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "blankslate",
          "blankslate-narrow": narrow,
          "blankslate-spacious": spacious
        )
      end

      def render?
        heading.present?
      end

      def wrapper
        unless @border
          yield
          return # returning `yield` caused a double render
        end

        content_tag(:div, class: "Box") do
          yield if block_given?
        end
      end
    end
  end
end
