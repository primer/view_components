# frozen_string_literal: true

module Primer
  module Beta
    # @label Blankslate
    class BlankslatePreview < ViewComponent::Preview
      # @label Playground
      #
      # @param narrow [Boolean] toggle
      # @param spacious [Boolean] toggle
      # @param border [Boolean] toggle
      def playground(narrow: false, spacious: false, border: false)
        render Primer::Beta::Blankslate.new(narrow: narrow, spacious: spacious, border: border) do |component|
          component.with_heading(tag: :h2).with_content("Title")
          component.with_description { "Description" }
        end
      end

      # @label Default options
      # @snapshot
      def default
        render Primer::Beta::Blankslate.new do |component|
          component.with_heading(tag: :h2).with_content("Title")
          component.with_description { "Description" }
        end
      end

      # @!group Options
      #
      # @label Narrow
      def option_narrow
        render Primer::Beta::Blankslate.new(narrow: true) do |component|
          component.with_heading(tag: :h2).with_content("Title")
          component.with_description { "Description" }
        end
      end

      # @label Spacious
      def option_spacious
        render Primer::Beta::Blankslate.new(spacious: true) do |component|
          component.with_heading(tag: :h2).with_content("Title")
          component.with_description { "Description" }
        end
      end

      # @label Border
      # @snapshot
      def option_border
        render Primer::Beta::Blankslate.new(border: true) do |component|
          component.with_heading(tag: :h2).with_content("Title")
          component.with_description { "Description" }
        end
      end
      #
      # @!endgroup

      # @param narrow [Boolean] toggle
      # @param spacious [Boolean] toggle
      # @param border [Boolean] toggle
      # @snapshot
      def with_icon(narrow: false, spacious: false, border: false)
        render Primer::Beta::Blankslate.new(narrow: narrow, spacious: spacious, border: border) do |component|
          component.with_visual_icon(icon: :shield)
          component.with_heading(tag: :h2).with_content("It looks like we have discovered a vulnerability")
        end
      end

      # @param narrow [Boolean] toggle
      # @param spacious [Boolean] toggle
      # @param border [Boolean] toggle
      # @snapshot
      def with_image(narrow: false, spacious: false, border: false)
        render Primer::Beta::Blankslate.new(narrow: narrow, spacious: spacious, border: border) do |component|
          component.with_heading(tag: :h2).with_content("Millions of teams trust GitHub to keep their work safe")
          component.with_visual_image(src: Primer::ExampleImage::BASE64_SRC, alt: "Security - secure vault")
        end
      end

      # @param narrow [Boolean] toggle
      # @param spacious [Boolean] toggle
      # @param border [Boolean] toggle
      # @snapshot
      def loading(narrow: false, spacious: false, border: false)
        render Primer::Beta::Blankslate.new(narrow: narrow, spacious: spacious, border: border) do |component|
          component.with_heading(tag: :h2).with_content("Mirroring your repository")
          component.with_description { "We’re currently mirroring this repository. It should take anywhere from a few minutes to a couple of hours depending on the size of the repository." }
          component.with_visual_spinner(size: :large)
        end
      end

      # @param narrow [Boolean] toggle
      # @param spacious [Boolean] toggle
      # @param border [Boolean] toggle
      # @snapshot
      def description(narrow: false, spacious: false, border: false)
        render Primer::Beta::Blankslate.new(narrow: narrow, spacious: spacious, border: border) do |component|
          component.with_heading(tag: :h2).with_content("It looks like we have discovered a vulnerability")
          component.with_description { "Millions of teams trust GitHub to keep their work safe" }
        end
      end

      # @param narrow [Boolean] toggle
      # @param spacious [Boolean] toggle
      # @param border [Boolean] toggle
      # @snapshot
      def primary_action(narrow: false, spacious: false, border: false)
        render Primer::Beta::Blankslate.new(narrow: narrow, spacious: spacious, border: border) do |component|
          component.with_heading(tag: :h2).with_content("It looks like we have discovered a vulnerability")
          component.with_primary_action(href: "#").with_content("Fix issue")
        end
      end

      # @param narrow [Boolean] toggle
      # @param spacious [Boolean] toggle
      # @param border [Boolean] toggle
      # @snapshot
      def secondary_action(narrow: false, spacious: false, border: false)
        render Primer::Beta::Blankslate.new(narrow: narrow, spacious: spacious, border: border) do |component|
          component.with_heading(tag: :h2).with_content("It looks like we have discovered a vulnerability")
          component.with_secondary_action(href: "#").with_content("Fix issue")
        end
      end

      # @param narrow [Boolean] toggle
      # @param spacious [Boolean] toggle
      # @param border [Boolean] toggle
      # @snapshot
      def full(narrow: false, spacious: false, border: false)
        render Primer::Beta::Blankslate.new(narrow: narrow, spacious: spacious, border: border) do |component|
          component.with_visual_icon(icon: :shield)
          component.with_heading(tag: :h2).with_content("It looks like we have discovered a vulnerability")
          component.with_description { "Millions of teams trust GitHub to keep their work safe" }
          component.with_primary_action(href: "#").with_content("Fix issue")
          component.with_secondary_action(href: "#").with_content("Learn more about vulnerabilities")
        end
      end

      def inside_flex_container
      end
    end
  end
end
