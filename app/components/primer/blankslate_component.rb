# frozen_string_literal: true

module Primer
  # Blankslates are for when there is a lack of content within a page or section. Use them as placeholders to tell users why something isn't there.
  #
  # ## Basic example
  #
  # The `Primer::BlankslateComponent` supports the following arguments to add a basic blankslate:
  #
  # 1. `title` (`String` required). Text that appears in a larger bold font.
  # 2. `description` (`String` optional). Text that appears below the title. Typically a whole sentence.
  #
  # ```ruby
  # <%= render Primer::BlankslateComponent.new(
  #   title: "Title",
  #   description: "Description",
  # ) %>
  # ```
  #
  # ## Icon or graphic (optional)
  #
  # Add an `icon` to give additional context. Please refer to the [Octicons](https://primer.style/octicons/) documentation to choose an icon.
  #
  # ```ruby
  # <%= render Primer::BlankslateComponent.new(
  #   icon: "octoface",
  #   title: "Title",
  #   description: "Description",
  # ) %>
  # ```
  #
  # Alternatively you can also add a graphic by providing a path (`image_src`) to an image instead.Also, make sure to add an alternative description (`image_alt`). It will be used for the `alt` tag.
  #
  # ```ruby
  # <%= render Primer::BlankslateComponent.new(
  #   image_src: "file.svg",
  #   image_alt: "Description of the image",
  #   title: "Title",
  #   description: "Description",
  # ) %>
  # ```
  #
  # Both icon and graphic will appear above the title.
  #
  #
  # ## Custom content (optional)
  #
  # You can add any custom content that typically is used instead of the description:
  #
  # ```ruby
  # <%= render Primer::BlankslateComponent.new(
  #   icon: "octoface",
  #   title: "Title",
  # ) do %>
  #   <p>Your custom content here</p>
  # <% end %>
  # ```
  #
  # ## Action button (optional)
  #
  # You can provide an action button to help users replace the blankslate. The button will appear below the description and custom content. It takes the following arguments:
  #
  # - `button_text` (`String` optional). The text of the button.
  # - `button_url` (`String` optional). The URL where the user will be taken after clicking the button.
  #
  # ```ruby
  # <%= render Primer::BlankslateComponent.new(
  #   icon: "book",
  #   title: "Welcome to the mona wiki!",
  #   description: "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.",
  #
  #   button_text: "Create the first page",
  #   button_url: "https://github.com/monalisa/mona/wiki/_new",
  # ) %>
  # ```
  #
  # ## Link (optional)
  #
  # Add an additional link to help users learn more about a feature. The link will be shown at the very bottom:
  #
  # - `link_text` (`String` optional). The text of the link.
  # - `link_url` (`String` optional). The URL where the user will be taken after clicking the link.
  #
  # ```ruby
  # <%= render Primer::BlankslateComponent.new(
  #   icon: "book",
  #   title: "Welcome to the mona wiki!",
  #   description: "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.",
  #   button_text: "Create the first page",
  #   button_url: "https://github.com/monalisa/mona/wiki/_new",
  #   link_text: "Learn more about wikis",
  #   link_url: "https://docs.github.com/en/github/building-a-strong-community/about-wikis",
  # ) %>
  # ```
  #
  # ## Variations (optional)
  #
  # There are a few variations of how the Blankslate appears:
  #
  # - `narrow` (`Boolean` optional). Adds a maximum width.
  #
  # ```ruby
  # <%= render Primer::BlankslateComponent.new(
  #   icon: "book",
  #   title: "Welcome to the mona wiki!",
  #   description: "Wikis provide a place in your repository to lay out the roadmap of your project, show the current status, and document software better, together.",
  #
  #   narrow: true,
  # ) %>
  # ```
  class BlankslateComponent < Primer::Component
    def initialize(
      # required
      title:,

      # optional
      title_tag: :h3,
      icon: "",
      image_src: "",
      image_alt: " ",
      description: "",
      button_text: "",
      button_url: "",
      button_classes: "btn-sm btn-primary",
      link_text: "",
      link_url: "",

      #variations
      narrow: false,

      **kwargs
    )
      @kwargs = kwargs
      @kwargs[:tag] = :div
      @kwargs[:classes] = class_names(
        @kwargs[:classes],
        "blankslate",
        "blankslate-narrow": narrow,
      )

      @title_tag = title_tag
      @icon = icon
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
