# frozen_string_literal: true

module Primer
  module Beta
    # Use `Blankslate` when there is a lack of content within a page or section. Use as placeholder to tell users why something isn't there.
    #
    # @accessibility
    #   - Set the `title` heading level based on what is appropriate for your page hierarchy. <%= link_to_heading_practices %>
    #   - `secondary_action` can be set to provide more information that is relevant in the context of the `Blankslate`.
    #   - `secondary_action` text should be meaningful out of context and clearly describe the destination. Avoid using vague text like, "Learn more" or "Click here".
    class Blankslate < Primer::Component
      include ViewComponent::PolymorphicSlots

      status :beta

      GRAPHIC_OPTIONS = %i[icon spinner image].freeze

      # Optional graphic visual.
      #
      # Use:
      #
      # - `graphic_icon` for an <%= link_to_component(Primer::OcticonComponent) %>.
      # - `graphic_image` for an <%= link_to_component(Primer::Image) %>.
      # - `graphic_spinner` for a <%= link_to_component(Primer::SpinnerComponent) %>.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :graphic, types: {
        icon: lambda { |**system_arguments|
          system_arguments[:mb] = 3
          system_arguments[:size] ||= :medium
          system_arguments[:classes] = class_names("blankslate-icon", system_arguments[:classes])

          Primer::OcticonComponent.new(**system_arguments)
        },
        spinner: lambda { |**system_arguments|
          system_arguments[:mb] = 3

          Primer::SpinnerComponent.new(**system_arguments)
        },
        image: lambda { |**system_arguments|
          system_arguments[:mb] = 3
          system_arguments[:size] = "56x56"

          Primer::Image.new(**system_arguments)
        }
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
      # - The description should always be informative and actionable.
      # - Don't use phrases like "You can".
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :description, lambda { |**system_arguments|
        system_arguments[:tag] = :p

        Primer::BaseComponent.new(**system_arguments)
      }

      # Optional Primary action
      #
      # Use this slot to set a call to action for users.
      #
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :primary_action, lambda { |href:, **system_arguments|
        system_arguments[:tag] = :a
        system_arguments[:href] = href
        system_arguments[:my] = 3
        system_arguments[:variant] = :large
        system_arguments[:scheme] ||= :primary

        Primer::ButtonComponent.new(**system_arguments)
      }

      # Optional Secondary action
      #
      # Use this slot to provide more information for the user.
      #
      # @param href [String] URL to be used for the link.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      renders_one :secondary_action, lambda { |href:, **system_arguments|
        system_arguments[:href] = href
        # Padding is needed to increase touch area.
        system_arguments[:p] = 3

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
      #       <% c.graphic_icon(icon: :globe) %>
      #       <% c.title(tag: :h2).with_content("Title") %>
      #       <% c.description { "Description"} %>
      #     <% end %>
      #
      # @example Loading
      #   @description
      #     Add a [SpinnerComponent](https://primer.style/view-components/components/spinner) to the blankslate in place of an icon.
      #   @code
      #     <%= render Primer::Beta::Blankslate.new do |c| %>
      #       <% c.graphic_spinner(size: :large) %>
      #       <% c.title(tag: :h2).with_content("Title") %>
      #       <% c.description { "Description"} %>
      #     <% end %>
      #
      # @example Using an image
      #   @description
      #     Add an `image` to give context that an Octicon couldn't.
      #   @code
      #     <%= render Primer::Beta::Blankslate.new do |c| %>
      #       <% c.graphic_image(src: "https://github.githubassets.com/images/modules/site/features/security-icon.svg", alt: "Security - secure vault") %>
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
      # @example Primary action
      #   @description
      #     Provide a `primary_action` to guide users to take action from the blankslate. The `primary_action` appears below the description and custom content.
      #   @code
      #     <%= render Primer::Beta::Blankslate.new do |c| %>
      #       <% c.graphic_icon(icon: :book) %>
      #       <% c.title(tag: :h2).with_content("Welcome to the mona wiki!") %>
      #       <% c.description { "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together."} %>
      #       <% c.primary_action(href: "https://github.com/monalisa/mona/wiki/_new").with_content("Create the first page") %>
      #     <% end %>
      #
      # @example Secondary action
      #   @description
      #     Add an additional `secondary_action` to help users learn more about a feature. See <%= link_to_accessibility %>. `secondary_action` will be shown at the very bottom:
      #   @code
      #     <%= render Primer::Beta::Blankslate.new do |c| %>
      #       <% c.graphic_icon(icon: :book) %>
      #       <% c.title(tag: :h2).with_content("Welcome to the mona wiki!") %>
      #       <% c.description { "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together."} %>
      #       <% c.secondary_action(href: "https://docs.github.com/en/github/building-a-strong-community/about-wikis").with_content("Learn more about wikis") %>
      #     <% end %>
      #
      # @example Primary and secondary actions
      #   @description
      #     `primary_action` and `secondary_action` can also be used together. The `primary_action` will always be rendered before the `secondary_action`:
      #   @code
      #     <%= render Primer::Beta::Blankslate.new do |c| %>
      #       <% c.graphic_icon(icon: :book) %>
      #       <% c.title(tag: :h2).with_content("Welcome to the mona wiki!") %>
      #       <% c.description { "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together."} %>
      #       <% c.primary_action(href: "https://github.com/monalisa/mona/wiki/_new").with_content("Create the first page") %>
      #       <% c.secondary_action(href: "https://docs.github.com/en/github/building-a-strong-community/about-wikis").with_content("Learn more about wikis") %>
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
      #       <% c.graphic_icon(icon: :book) %>
      #       <% c.title(tag: :h2).with_content("Welcome to the mona wiki!") %>
      #       <% c.description { "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together."} %>
      #     <% end %>
      #
      # @example With border
      #   @description
      #     It's possible to add a border around the Blankslate. This will wrap the Blankslate in a BorderBox.
      #   @code
      #     <%= render Primer::Beta::Blankslate.new(border: true) do |c| %>
      #       <% c.graphic_icon(icon: :book) %>
      #       <% c.title(tag: :h2).with_content("Welcome to the mona wiki!") %>
      #       <% c.description { "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together."} %>
      #     <% end %>
      #
      # @param narrow [Boolean] Adds a maximum width to the Blankslate.
      # @param large [Boolean] Increases the font size in the Blankslate.
      # @param spacious [Boolean] Increases the vertical padding.
      # @param border [Boolean] Adds a border around the Blankslate.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(narrow: false, large: false, spacious: false, border: false, **system_arguments)
        @border = border
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
