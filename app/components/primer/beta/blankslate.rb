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
      # - `visual_spinner` for a <%= link_to_component(Primer::SpinnerComponent) %>.
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

          Primer::SpinnerComponent.new(**system_arguments)
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

      # @example Basic
      #   <%= render Primer::Beta::Blankslate.new do |c| %>
      #     <% c.heading(tag: :h2).with_content("Title") %>
      #     <% c.description { "Description"} %>
      #   <% end %>
      #
      # @example Icon
      #   @description
      #     Add an `icon` to give additional context. Refer to the [Octicons](https://primer.style/octicons/) documentation to choose an icon.
      #   @code
      #     <%= render Primer::Beta::Blankslate.new do |c| %>
      #       <% c.visual_icon(icon: :globe) %>
      #       <% c.heading(tag: :h2).with_content("Title") %>
      #       <% c.description { "Description"} %>
      #     <% end %>
      #
      # @example Loading
      #   @description
      #     Add a [SpinnerComponent](https://primer.style/view-components/components/spinner) to the blankslate in place of an icon.
      #   @code
      #     <%= render Primer::Beta::Blankslate.new do |c| %>
      #       <% c.visual_spinner(size: :large) %>
      #       <% c.heading(tag: :h2).with_content("Title") %>
      #       <% c.description { "Description"} %>
      #     <% end %>
      #
      # @example Using an image
      #   @description
      #     Add an `image` to give context that an Octicon couldn't.
      #   @code
      #     <%= render Primer::Beta::Blankslate.new do |c| %>
      #       <% c.visual_image(src: Primer::ExampleImage::BASE64_SRC, alt: "Security - secure vault") %>
      #       <% c.heading(tag: :h2).with_content("Title") %>
      #       <% c.description { "Description"} %>
      #     <% end %>
      #
      # @example Custom content
      #   @description
      #     Pass custom content to `description`.
      #   @code
      #     <%= render Primer::Beta::Blankslate.new do |c| %>
      #       <% c.heading(tag: :h2).with_content("Title") %>
      #       <% c.description do %>
      #         <em>Your custom content here</em>
      #       <% end %>
      #     <% end %>
      #
      # @example Primary action
      #   @description
      #     Provide a `primary_action` to guide users to take action from the blankslate. The `primary_action` appears below the description and custom content.
      #   @code
      #     <%= render Primer::Beta::Blankslate.new do |c| %>
      #       <% c.visual_icon(icon: :book) %>
      #       <% c.heading(tag: :h2).with_content("Welcome to the mona wiki!") %>
      #       <% c.description { "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together."} %>
      #       <% c.primary_action(href: "https://github.com/monalisa/mona/wiki/_new").with_content("Create the first page") %>
      #     <% end %>
      #
      # @example Secondary action
      #   @description
      #     Add an additional `secondary_action` to help users learn more about a feature. See <%= link_to_accessibility %>. `secondary_action` will be shown at the very bottom:
      #   @code
      #     <%= render Primer::Beta::Blankslate.new do |c| %>
      #       <% c.visual_icon(icon: :book) %>
      #       <% c.heading(tag: :h2).with_content("Welcome to the mona wiki!") %>
      #       <% c.description { "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together."} %>
      #       <% c.secondary_action(href: "https://docs.github.com/en/github/building-a-strong-community/about-wikis").with_content("Learn more about wikis") %>
      #     <% end %>
      #
      # @example Primary and secondary actions
      #   @description
      #     `primary_action` and `secondary_action` can also be used together. The `primary_action` will always be rendered before the `secondary_action`:
      #   @code
      #     <%= render Primer::Beta::Blankslate.new do |c| %>
      #       <% c.visual_icon(icon: :book) %>
      #       <% c.heading(tag: :h2).with_content("Welcome to the mona wiki!") %>
      #       <% c.description { "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together."} %>
      #       <% c.primary_action(href: "https://github.com/monalisa/mona/wiki/_new").with_content("Create the first page") %>
      #       <% c.secondary_action(href: "https://docs.github.com/en/github/building-a-strong-community/about-wikis").with_content("Learn more about wikis") %>
      #     <% end %>
      #
      # @example Variations
      #   @description
      #     There are a few variations of how the Blankslate appears: `narrow` adds a maximum width of `485px`, and `spacious` increases the padding from `32px` to `80px 40px`.
      #   @code
      #     <%= render Primer::Beta::Blankslate.new(
      #       narrow: true,
      #       spacious: true,
      #     ) do |c| %>
      #       <% c.visual_icon(icon: :book) %>
      #       <% c.heading(tag: :h2).with_content("Welcome to the mona wiki!") %>
      #       <% c.description { "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together."} %>
      #     <% end %>
      #
      # @example With border
      #   @description
      #     It's possible to add a border around the Blankslate. This will wrap the Blankslate in a BorderBox.
      #   @code
      #     <%= render Primer::Beta::Blankslate.new(border: true) do |c| %>
      #       <% c.visual_icon(icon: :book) %>
      #       <% c.heading(tag: :h2).with_content("Welcome to the mona wiki!") %>
      #       <% c.description { "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together."} %>
      #     <% end %>
      #
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
