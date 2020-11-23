# frozen_string_literal: true

module Primer
  # Use Primer::BlankslateComponent when there is a lack of content within a page or section. Use as placeholder to tell users why something isn't there.
  class BlankslateComponent < Primer::Component
    #
    # @example 150|Basic
    #   <%= render Primer::BlankslateComponent.new(
    #     title: "Title",
    #     description: "Description",
    #   ) %>
    #
    # @example 190|Icon|Add an `icon` to give additional context. Refer to the [Octicons](https://primer.style/octicons/) documentation to choose an icon.
    #   <%= render Primer::BlankslateComponent.new(
    #     icon: "octoface",
    #     title: "Title",
    #     description: "Description",
    #   ) %>
    #
    # @example 150|Custom content|Pass custom content as a block in place of `description`.
    #   <%= render Primer::BlankslateComponent.new(
    #     title: "Title",
    #   ) do %>
    #     <em>Your custom content here</em>
    #   <% end %>
    #
    # @example 270|Action button|Provide a button to guide users to take action from the blankslate. The button appears below the description and custom content.
    #   <%= render Primer::BlankslateComponent.new(
    #     icon: "book",
    #     title: "Welcome to the mona wiki!",
    #     description: "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.",
    #
    #     button_text: "Create the first page",
    #     button_url: "https://github.com/monalisa/mona/wiki/_new",
    #   ) %>
    #
    # @example 225|Link|Add an additional link to help users learn more about a feature. The link will be shown at the very bottom:
    #   <%= render Primer::BlankslateComponent.new(
    #     icon: "book",
    #     title: "Welcome to the mona wiki!",
    #     description: "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.",
    #     link_text: "Learn more about wikis",
    #     link_url: "https://docs.github.com/en/github/building-a-strong-community/about-wikis",
    #   ) %>
    #
    # @example 340|Variations|There are a few variations of how the Blankslate appears: `narrow` adds a maximum width, `large` increases the font size, and `spacious` adds extra padding.
    #   <%= render Primer::BlankslateComponent.new(
    #     icon: "book",
    #     title: "Welcome to the mona wiki!",
    #     description: "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.",
    #     narrow: true,
    #     large: true,
    #     spacious: true,
    #   ) %>
    #
    # @param title [String] Text that appears in a larger bold font.
    # @param title_tag [Symbol] HTML tag to use for title.
    # @param icon [String] Octicon icon to use at top of component.
    # @param icon_size [Symbol] <%= one_of(Primer::OcticonComponent::SIZE_MAPPINGS) %>
    # @param image_src [String] Image to display.
    # @param image_alt [String] Alt text for image.
    # @param description [String] Text that appears below the title. Typically a whole sentence.
    # @param button_text [String] The text of the button.
    # @param button_url [String] The URL where the user will be taken after clicking the button.
    # @param button_classes [String] Classes to apply to action button
    # @param link_text [String] The text of the link.
    # @param link_url [String] The URL where the user will be taken after clicking the link.
    # @param narrow [Boolean] Adds a maximum width.
    # @param large [Boolean] Increases the font size.
    # @param spacious [Boolean] Adds extra padding.
    def initialize(
      title: "",
      title_tag: :h3,
      icon: "",
      icon_size: :medium,
      image_src: "",
      image_alt: " ",
      description: "",
      button_text: "",
      button_url: "",
      button_classes: "btn-primary my-3",
      link_text: "",
      link_url: "",

      #variations
      narrow: false,
      large: false,
      spacious: false,

      **system_arguments
    )
      @system_arguments = system_arguments
      @system_arguments[:tag] ||= :div
      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        "blankslate",
        "blankslate-narrow": narrow,
        "blankslate-large": large,
        "blankslate-spacious": spacious,
      )

      @title_tag = title_tag
      @icon = icon
      @icon_size = icon_size
      @image_src = image_src
      @image_alt = image_alt
      @title = title
      @description = description
      @button_text = button_text
      @button_url = button_url
      @button_classes = button_classes
      @link_text = link_text
      @link_url = link_url
    end
  end
end
