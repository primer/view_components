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
        render Primer::Beta::Blankslate.new(narrow: narrow, spacious: spacious, border: border) do |c|
          c.heading(tag: :h2).with_content("Title")
          c.description { "Description" }
        end
      end

      # @label Default options
      def default
        render Primer::Beta::Blankslate.new do |c|
          c.heading(tag: :h2).with_content("Title")
          c.description { "Description" }
        end
      end

      # @!group Options
      #
      # @label Narrow
      def option_narrow
        render Primer::Beta::Blankslate.new(narrow: true) do |c|
          c.heading(tag: :h2).with_content("Title")
          c.description { "Description" }
        end
      end

      # @label Spacious
      def option_spacious
        render Primer::Beta::Blankslate.new(spacious: true) do |c|
          c.heading(tag: :h2).with_content("Title")
          c.description { "Description" }
        end
      end

      # @label Border
      def option_border
        render Primer::Beta::Blankslate.new(border: true) do |c|
          c.heading(tag: :h2).with_content("Title")
          c.description { "Description" }
        end
      end
      #
      # @!endgroup

      # @param narrow [Boolean] toggle
      # @param spacious [Boolean] toggle
      # @param border [Boolean] toggle
      def with_icon(narrow: false, spacious: false, border: false)
        render Primer::Beta::Blankslate.new(narrow: narrow, spacious: spacious, border: border) do |c|
          c.visual_icon(icon: :shield)
          c.heading(tag: :h2).with_content("It looks like we have discovered a vulnerability")
        end
      end

      # @param narrow [Boolean] toggle
      # @param spacious [Boolean] toggle
      # @param border [Boolean] toggle
      def with_image(narrow: false, spacious: false, border: false)
        render Primer::Beta::Blankslate.new(narrow: narrow, spacious: spacious, border: border) do |c|
          c.heading(tag: :h2).with_content("Millions of teams trust GitHub to keep their work safe")
          c.visual_image(src: Primer::ExampleImage::BASE64_SRC, alt: "Security - secure vault")
        end
      end

      # @param narrow [Boolean] toggle
      # @param spacious [Boolean] toggle
      # @param border [Boolean] toggle
      def loading(narrow: false, spacious: false, border: false)
        render Primer::Beta::Blankslate.new(narrow: narrow, spacious: spacious, border: border) do |c|
          c.heading(tag: :h2).with_content("Mirroring your repository")
          c.description { "We’re currently mirroring this repository. It should take anywhere from a few minutes to a couple of hours depending on the size of the repository." }
          c.visual_spinner(size: :large)
        end
      end

      # @param narrow [Boolean] toggle
      # @param spacious [Boolean] toggle
      # @param border [Boolean] toggle
      def description(narrow: false, spacious: false, border: false)
        render Primer::Beta::Blankslate.new(narrow: narrow, spacious: spacious, border: border) do |c|
          c.heading(tag: :h2).with_content("It looks like we have discovered a vulnerability")
          c.description { "Millions of teams trust GitHub to keep their work safe" }
        end
      end

      # @param narrow [Boolean] toggle
      # @param spacious [Boolean] toggle
      # @param border [Boolean] toggle
      def primary_action(narrow: false, spacious: false, border: false)
        render Primer::Beta::Blankslate.new(narrow: narrow, spacious: spacious, border: border) do |c|
          c.heading(tag: :h2).with_content("It looks like we have discovered a vulnerability")
          c.primary_action(href: "#").with_content("Fix issue")
        end
      end

      # @param narrow [Boolean] toggle
      # @param spacious [Boolean] toggle
      # @param border [Boolean] toggle
      def secondary_action(narrow: false, spacious: false, border: false)
        render Primer::Beta::Blankslate.new(narrow: narrow, spacious: spacious, border: border) do |c|
          c.heading(tag: :h2).with_content("It looks like we have discovered a vulnerability")
          c.secondary_action(href: "#").with_content("Fix issue")
        end
      end

      # @param narrow [Boolean] toggle
      # @param spacious [Boolean] toggle
      # @param border [Boolean] toggle
      def full(narrow: false, spacious: false, border: false)
        render Primer::Beta::Blankslate.new(narrow: narrow, spacious: spacious, border: border) do |c|
          c.visual_icon(icon: :shield)
          c.heading(tag: :h2).with_content("It looks like we have discovered a vulnerability")
          c.description { "Millions of teams trust GitHub to keep their work safe" }
          c.primary_action(href: "#").with_content("Fix issue")
          c.secondary_action(href: "#").with_content("Learn more about vulnerabilities")
        end
      end
    end
  end
end
