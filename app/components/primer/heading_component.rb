# frozen_string_literal: true

module Primer
  # `Heading` can be used to communicate page organization and hierarchy.
  #
  # - Set tag to one of `:h1`, `:h2`, `:h3`, `:h4`, `:h5`, `:h6` based on what is
  #   appropriate for the page context.
  # - Use `Heading` as the title of a section or sub section.
  # - Do not use `Heading` for styling alone. To style text without conveying heading semantics,
  #   consider using <%= link_to_component(Primer::TextComponent) %> with relevant <%= link_to_typography_docs %>.
  # - Do not jump heading levels. For instance, do not follow a `<h1>` with an `<h3>`. Heading levels should
  #   increase by one in ascending order.
  #
  # @accessibility
  #   Headings convey semantic meaning. Assistive technology users rely on headings to quickly navigate and scan information on a page.
  #   Inappropriate use of headings can lead to a confusing experience.
  #   <%= link_to_heading_practices %>
  class HeadingComponent < Primer::Component
    status :beta

    TAG_FALLBACK = :h2
    TAG_OPTIONS = [:h1, TAG_FALLBACK, :h3, :h4, :h5, :h6].freeze

    # @example Default
    #   <%= render(Primer::HeadingComponent.new(tag: :h1)) { "H1 Text" } %>
    #   <%= render(Primer::HeadingComponent.new(tag: :h2)) { "H2 Text" } %>
    #   <%= render(Primer::HeadingComponent.new(tag: :h3)) { "H3 Text" } %>
    #   <%= render(Primer::HeadingComponent.new(tag: :h4)) { "H4 Text" } %>
    #   <%= render(Primer::HeadingComponent.new(tag: :h5)) { "H5 Text" } %>
    #   <%= render(Primer::HeadingComponent.new(tag: :h6)) { "H6 Text" } %>
    #
    # @example With `font_size`
    #   <%= render(Primer::HeadingComponent.new(tag: :h1, font_size: 6)) { "h1 tag, font_size 6" } %>
    #   <%= render(Primer::HeadingComponent.new(tag: :h2, font_size: 3)) { "h2 tag, font_size 3" } %>
    #   <%= render(Primer::HeadingComponent.new(tag: :h3, font_size: 2)) { "h3 tag, font_size 2" } %>
    #   <%= render(Primer::HeadingComponent.new(tag: :h5, font_size: 1)) { "h5 tag, font_size 1" } %>
    #   <%= render(Primer::HeadingComponent.new(tag: :h6, font_size: 4)) { "h6 tag, font_size 4" } %>
    #
    # @param tag [String]  <%= one_of(Primer::HeadingComponent::TAG_OPTIONS) %>
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
