# frozen_string_literal: true

require "octicons"

module Primer
  # `Octicon` renders an <%= link_to_octicons %> with <%= link_to_system_arguments_docs %>.
  # `Octicon` can also be rendered with the `primer_octicon` helper, which accepts the same arguments.
  class OcticonComponent < Primer::Component
    status :beta

    SIZE_DEFAULT = :small
    SIZE_MAPPINGS = {
      SIZE_DEFAULT => 16,
      :medium => 32,
      :large => 64
    }.freeze
    SIZE_OPTIONS = SIZE_MAPPINGS.keys

    # @example Default
    #   <%= render(Primer::OcticonComponent.new("check")) %>
    #   <%= render(Primer::OcticonComponent.new(icon: "check")) %>
    #
    # @example Medium
    #   <%= render(Primer::OcticonComponent.new("people", size: :medium)) %>
    #
    # @example Large
    #   <%= render(Primer::OcticonComponent.new("x", size: :large)) %>
    #
    # @example Helper
    #   <%= primer_octicon("check") %>
    #
    # @param icon [String] Name of <%= link_to_octicons %> to use.
    # @param size [Symbol] <%= one_of(Primer::OcticonComponent::SIZE_MAPPINGS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(icon_name = nil, icon: nil, size: SIZE_DEFAULT, **system_arguments)
      icon_key = icon_name || icon
      cache_key = [icon_key, size, system_arguments.slice(:height, :width)].join("_")

      @system_arguments = system_arguments
      @system_arguments[:tag] = :svg
      @system_arguments[:aria] ||= {}

      if @system_arguments[:aria][:label] || @system_arguments[:"aria-label"]
        @system_arguments[:role] = "img"
      else
        @system_arguments[:aria][:hidden] = true
      end

      if (cache_icon = Primer::Octicon::Cache.read(cache_key))
        @icon = cache_icon
      else
        # Filter out classify options to prevent them from becoming invalid html attributes.
        # Note height and width are both classify options and valid html attributes.
        octicon_options = {
          height: SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, SIZE_DEFAULT)]
        }.merge(@system_arguments.slice(:height, :width))

        @icon = Octicons::Octicon.new(icon_key, octicon_options)
        Primer::Octicon::Cache.set(cache_key, @icon)
      end

      @system_arguments[:classes] = class_names(
        @icon.options[:class],
        @system_arguments[:classes]
      )
      @system_arguments.merge!(@icon.options.except(:class, :'aria-hidden'))
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { @icon.path.html_safe } # rubocop:disable Rails/OutputSafety
    end

    Primer::Octicon::Cache.preload!
  end
end
