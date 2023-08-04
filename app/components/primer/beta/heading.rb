# frozen_string_literal: true

module Primer
  module Beta
    # `Heading` should be used to communicate page organization and hierarchy.
    #
    # - Set tag to one of `:h1`, `:h2`, `:h3`, `:h4`, `:h5`, `:h6` based on what is appropriate for the page context.
    # - Use `Heading` as the title of a section or sub section.
    # - Do not use `Heading` for styling alone. For simply styling text, consider using <%= link_to_component(Primer::Beta::Text) %> with relevant <%= link_to_typography_docs %>
    #   such as `font_size` and `font_weight`.
    # - Do not jump heading levels. For instance, do not follow a `<h1>` with an `<h3>`. Heading levels should increase by one in ascending order.
    #
    # @accessibility
    #   While sighted users rely on visual cues such as font size changes to determine what the heading is, assistive technology users rely on programatic cues that can be read out.
    #   When text on a page is visually implied to be a heading, ensure that it is coded as a heading. Additionally, visually implied heading level and coded heading level should be
    #   consistent. [See WCAG success criteria: 1.3.1: Info and Relationships](https://www.w3.org/WAI/WCAG21/Understanding/info-and-relationships.html)
    #
    #   Headings allow assistive technology users to quickly navigate around a page. Navigation to text that is not meant to be a heading can be a confusing experience.
    #   <%= link_to_heading_practices %>
    class Heading < Primer::Component
      status :beta

      TAG_FALLBACK = :h2
      TAG_OPTIONS = [:h1, TAG_FALLBACK, :h3, :h4, :h5, :h6].freeze

      # @param tag [String]  <%= one_of(Primer::Beta::Heading::TAG_OPTIONS) %>
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(tag:, **system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, TAG_FALLBACK)
      end

      def call
        render(Primer::BaseComponent.new(**@system_arguments)) { content }
      end
    end
  end
end
