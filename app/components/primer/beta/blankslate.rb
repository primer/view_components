# frozen_string_literal: true

module Primer
  module Beta
    # Use `Blankslate` when there is a lack of content within a page or section. Use as placeholder to tell users why something isn't there.
    # @accessibility
    #   `Blankslate` renders an `<h3>` element for the title by default. Update the heading level based on what is appropriate for your page hierarchy by setting `title_tag`.
    #   <%= link_to_heading_practices %>
    class Blankslate < Primer::Component
      status :beta

      # Optional Spinner.
      #
      # @param system_arguments [Hash] The same arguments as <%= link_to_component(Primer::SpinnerComponent) %>.
      renders_one :spinner, lambda { |**system_arguments|
        system_arguments[:mb] ||= 3
        Primer::SpinnerComponent.new(**system_arguments)
      }

      # Optional Icon.
      #
      # @param icon [Symbol, String] Name of <%= link_to_octicons %> to use.
      # @param system_arguments [Hash] The same arguments as <%= link_to_component(Primer::SpinnerComponent) %>.
      renders_one :icon, lambda { |icon:, **system_arguments|
        system_arguments[:icon] = icon
        system_arguments[:size] ||= :medium
        system_arguments[:classes] = class_names("blankslate-icon", system_arguments[:classes])

        Primer::OcticonComponent.new(**system_arguments)
      }

      # Optional Image.
      #
      # @param src [String] The source url of the image.
      # @param alt [String] Specifies an alternate text for the image.
      # @param system_arguments [Hash] The same arguments as <%= link_to_component(Primer::SpinnerComponent) %>.
      renders_one :image, lambda { |src:, alt:, **system_arguments|
        system_arguments[:src] = src
        system_arguments[:alt] = alt
        system_arguments[:size] = "56x56"
        system_arguments[:mb] = 3

        Primer::Image.new(**system_arguments)
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
      renders_one :description, lambda { |**system_arguments|
        system_arguments[:tag] = :p

        Primer::BaseComponent.new(**system_arguments)
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
      #       <% c.icon(icon: :globe) %>
      #       <% c.title(tag: :h2).with_content("Title") %>
      #       <% c.description { "Description"} %>
      #     <% end %>
      #
      # @example Loading
      #   @description
      #     Add a [SpinnerComponent](https://primer.style/view-components/components/spinner) to the blankslate in place of an icon.
      #   @code
      #     <%= render Primer::Beta::Blankslate.new do |c| %>
      #       <% c.title(tag: :h2).with_content("Title") %>
      #       <% c.description { "Description"} %>
      #       <% c.spinner(size: :large) %>
      #     <% end %>
      #
      # @example Using an image
      #   @description
      #     Add an `image` to give context that an Octicon couldn't.
      #   @code
      #     <%= render Primer::Beta::Blankslate.new do |c| %>
      #       <% c.title(tag: :h2).with_content("Title") %>
      #       <% c.description { "Description"} %>
      #       <% c.image(src: "https://github.githubassets.com/images/modules/site/features/security-icon.svg", alt: "Security - secure vault") %>
      #     <% end %>
      #
      # @example Custom content
      #   @description
      #     Pass custom content as a block in place of `description`.
      #   @code
      #     <%= render Primer::Beta::Blankslate.new do |c| %>
      #       <% c.title(tag: :h2).with_content("Title") %>
      #       <em>Your custom content here</em>
      #     <% end %>
      #
      # @example Action button
      #   @description
      #     Provide a button to guide users to take action from the blankslate. The button appears below the description and custom content.
      #   @code
      #     <%= render Primer::Beta::Blankslate.new(
      #       button_text: "Create the first page",
      #       button_url: "https://github.com/monalisa/mona/wiki/_new",
      #     ) do |c| %>
      #       <% c.icon(icon: :book) %>
      #       <% c.title(tag: :h2).with_content("Welcome to the mona wiki!") %>
      #       <% c.description { "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together."} %>
      #     <% end %>
      #
      # @example Link
      #   @description
      #     Add an additional link to help users learn more about a feature. The link will be shown at the very bottom:
      #   @code
      #     <%= render Primer::Beta::Blankslate.new(
      #       link_text: "Learn more about wikis",
      #       link_url: "https://docs.github.com/en/github/building-a-strong-community/about-wikis",
      #     ) do |c| %>
      #       <% c.icon(icon: :book) %>
      #       <% c.title(tag: :h2).with_content("Welcome to the mona wiki!") %>
      #       <% c.description { "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together."} %>
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
      #       <% c.icon(icon: :book) %>
      #       <% c.title(tag: :h2).with_content("Welcome to the mona wiki!") %>
      #       <% c.description { "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together."} %>
      #     <% end %>
      #
      # @param button_text [String] The text of the button.
      # @param button_url [String] The URL where the user will be taken after clicking the button.
      # @param button_classes [String] Classes to apply to action button
      # @param link_text [String] The text of the link.
      # @param link_url [String] The URL where the user will be taken after clicking the link.
      # @param narrow [Boolean] Adds a maximum width.
      # @param large [Boolean] Increases the font size.
      # @param spacious [Boolean] Adds extra padding.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(
        button_text: "",
        button_url: "",
        button_classes: "btn-primary my-3",
        link_text: "",
        link_url: "",

        # variations
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

        @button_text = button_text
        @button_url = button_url
        @button_classes = button_classes
        @link_text = link_text
        @link_url = link_url
      end

      def render?
        title.present?
      end
    end
  end
end
