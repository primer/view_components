# frozen_string_literal: true

module Primer
  # Use `Blankslate` when there is a lack of content within a page or section. Use as placeholder to tell users why something isn't there.
  # @accessibility
  #   `Blankslate` renders an `<h3>` element for the title by default. Update the heading level based on what is appropriate for your page hierarchy by setting `title_tag`.
  #   <%= link_to_heading_practices %>
  class BlankslateComponent < Primer::Component
    status :deprecated

    # Optional Spinner.
    #
    # @param kwargs [Hash] The same arguments as <%= link_to_component(Primer::Beta::Spinner) %>.
    renders_one :spinner, lambda { |**system_arguments|
      system_arguments[:mb] ||= 3
      Primer::Beta::Spinner.new(**system_arguments)
    }

    # @param title [String] Text that appears in a larger bold font.
    # @param title_tag [Symbol] HTML tag to use for title.
    # @param icon [Symbol] Octicon icon to use at top of component.
    # @param icon_size [Symbol] <%= one_of(Primer::Beta::Octicon::SIZE_MAPPINGS, sort: false) %>
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
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
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
