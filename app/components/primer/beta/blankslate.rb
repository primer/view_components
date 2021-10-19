# frozen_string_literal: true

module Primer
  module Beta
    # Use `Blankslate` when there is a lack of content within a page or section. Use as placeholder to tell users why something isn't there.
    # @accessibility
    #   `Blankslate` renders an `<h3>` element for the title by default. Update the heading level based on what is appropriate for your page hierarchy by setting `title_tag`.
    #   <%= link_to_heading_practices %>
    class Blankslate < Primer::Component
      status :beta

      GRAPHIC_OPTIONS = %i[icon spinner image].freeze

      # Optional graphic visual.
      #
      # @param type [Symbol]  <%= one_of(Primer::Beta::Blankslate::GRAPHIC_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :graphic, lambda { |type, **system_arguments|
        system_arguments[:mb] = 3

        case type
        when :icon
          system_arguments[:size] ||= :medium
          system_arguments[:classes] = class_names("blankslate-icon", system_arguments[:classes])

          Primer::OcticonComponent.new(**system_arguments)
        when :spinner
          Primer::SpinnerComponent.new(**system_arguments)
        when :image
          system_arguments[:size] = "56x56"

          Primer::Image.new(**system_arguments)
        else
          raise ArgumentError, "`type` must be one of #{GRAPHIC_OPTIONS.join(',')}."
        end
      }

      # Required Title.
      #
      # @param tag [String]  <%= one_of(Primer::HeadingComponent::TAG_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :title, lambda { |tag:, **system_arguments|
        system_arguments[:tag] = tag
        system_arguments[:mb] = 1
        system_arguments[:classes] = class_names("h2", system_arguments[:classes])

        Primer::HeadingComponent.new(**system_arguments)
      }

      # Optional Description.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :description, -> { Primer::BaseComponent.new(tag: :p) }

      # Optional Button
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :button, lambda { |href:, **system_arguments|
        system_arguments[:tag] = :a
        system_arguments[:href] = href
        system_arguments[:my] = 3
        system_arguments[:scheme] ||= :primary

        Primer::ButtonComponent.new(**system_arguments)
      }

      # Optional Link
      #
      # @param href [String] URL to be used for the link.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :link, lambda { |href:, **system_arguments|
        system_arguments[:href] = href

        Primer::LinkComponent.new(**system_arguments)
      }

      #
      # @example Basic
      #   <%= render Primer::Beta::Blankslate.new do |c| %>
      #     <% c.title(tag: :h2).with_content("Title") %>
      #     <% c.description { "Description"} %>
      #   <% end %>
      #
      # @example Icon
      #   @description
      #     Add an `icon` to give additional context. Refer to the [Octicons](https://primer.style/octicons/) documentation to choose an icon.
      #   @code
      #     <%= render Primer::Beta::Blankslate.new(icon: :globe) do |c| %>
      #       <% c.graphic(:icon, icon: :globe) %>
      #       <% c.title(tag: :h2).with_content("Title") %>
      #       <% c.description { "Description"} %>
      #     <% end %>
      #
      # @example Loading
      #   @description
      #     Add a [SpinnerComponent](https://primer.style/view-components/components/spinner) to the blankslate in place of an icon.
      #   @code
      #     <%= render Primer::Beta::Blankslate.new do |c| %>
      #       <% c.graphic(:spinner, size: :large) %>
      #       <% c.title(tag: :h2).with_content("Title") %>
      #       <% c.description { "Description"} %>
      #     <% end %>
      #
      # @example Using an image
      #   @description
      #     Add an `image` to give context that an Octicon couldn't.
      #   @code
      #     <%= render Primer::Beta::Blankslate.new do |c| %>
      #       <% c.graphic(:image, src: "https://github.githubassets.com/images/modules/site/features/security-icon.svg", alt: "Security - secure vault") %>
      #       <% c.title(tag: :h2).with_content("Title") %>
      #       <% c.description { "Description"} %>
      #     <% end %>
      #
      # @example Custom content
      #   @description
      #     Pass custom content to `description`.
      #   @code
      #     <%= render Primer::Beta::Blankslate.new do |c| %>
      #       <% c.title(tag: :h2).with_content("Title") %>
      #       <% c.description do %>
      #         <em>Your custom content here</em>
      #       <% end %>
      #     <% end %>
      #
      # @example Action button
      #   @description
      #     Provide a button to guide users to take action from the blankslate. The button appears below the description and custom content.
      #   @code
      #     <%= render Primer::Beta::Blankslate.new do |c| %>
      #       <% c.graphic(:icon, icon: :book) %>
      #       <% c.title(tag: :h2).with_content("Welcome to the mona wiki!") %>
      #       <% c.description { "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together."} %>
      #       <% c.button(href: "https://github.com/monalisa/mona/wiki/_new").with_content("Create the first page") %>
      #     <% end %>
      #
      # @example Link
      #   @description
      #     Add an additional link to help users learn more about a feature. The link will be shown at the very bottom:
      #   @code
      #     <%= render Primer::Beta::Blankslate.new do |c| %>
      #       <% c.graphic(:icon, icon: :book) %>
      #       <% c.title(tag: :h2).with_content("Welcome to the mona wiki!") %>
      #       <% c.description { "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together."} %>
      #       <% c.link(href: "https://docs.github.com/en/github/building-a-strong-community/about-wikis").with_content("Learn more about wikis") %>
      #     <% end %>
      #
      # @example Variations
      #   @description
      #     There are a few variations of how the Blankslate appears: `narrow` adds a maximum width, `large` increases the font size, and `spacious` adds extra padding.
      #   @code
      #     <%= render Primer::Beta::Blankslate.new(
      #       narrow: true,
      #       large: true,
      #       spacious: true,
      #     ) do |c| %>
      #       <% c.graphic(:icon, icon: :book) %>
      #       <% c.title(tag: :h2).with_content("Welcome to the mona wiki!") %>
      #       <% c.description { "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together."} %>
      #     <% end %>
      #
      # @param narrow [Boolean] Adds a maximum width.
      # @param large [Boolean] Increases the font size.
      # @param spacious [Boolean] Adds extra padding.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        narrow: false,
        large: false,
        spacious: false,

        **system_arguments
      )
        @system_arguments = system_arguments
        @system_arguments[:tag] = :div
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "blankslate",
          "blankslate-narrow": narrow,
          "blankslate-large": large,
          "blankslate-spacious": spacious
        )
      end

      def render?
        title.present?
      end
    end
  end
end
