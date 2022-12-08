# frozen_string_literal: true

require "octicons"

module Primer
  # `Octicon` renders an <%= link_to_octicons %> with <%= link_to_system_arguments_docs %>.
  # `Octicon` can also be rendered with the `primer_octicon` helper, which accepts the same arguments.
  class OcticonComponent < Primer::Component
    warn_on_deprecated_slot_setter

    status :beta

    SIZE_XSMALL = :xsmall
    SIZE_DEFAULT = :small
    SIZE_MEDIUM = :medium

    SIZE_MAPPINGS = {
      SIZE_XSMALL => 12,
      SIZE_DEFAULT => 16,
      SIZE_MEDIUM => 24
    }.freeze
    SIZE_OPTIONS = SIZE_MAPPINGS.keys

    # @example Default
    #   <%= render(Primer::OcticonComponent.new(:check)) %>
    #   <%= render(Primer::OcticonComponent.new(icon: :check)) %>
    #
    # @example Medium
    #   <%= render(Primer::OcticonComponent.new(:people, size: :medium)) %>
    #
    # @example Helper
    #   <%= primer_octicon(:check) %>
    #
    # @param icon_name [Symbol, String] Name of <%= link_to_octicons %> to use.
    # @param icon [Symbol, String] Name of <%= link_to_octicons %> to use.
    # @param size [Symbol] <%= one_of(Primer::OcticonComponent::SIZE_MAPPINGS, sort: false) %>
    # @param use_symbol [Boolean] EXPERIMENTAL (May change or be removed) - Set to true when using with <%= link_to_component(Primer::OcticonSymbolsComponent) %>.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(icon_name = nil, icon: nil, size: SIZE_DEFAULT, use_symbol: false, **system_arguments)
      icon_key = icon_name || icon

      # Don't allow sizes under 16px
      if system_arguments[:height].present? && system_arguments[:height].to_i < 16 || system_arguments[:width].present? && system_arguments[:width].to_i < 16
        system_arguments.delete(:height)
        system_arguments.delete(:width)
      end

      cache_key = Primer::Octicon::Cache.get_key(
        symbol: icon_key,
        size: size,
        height: system_arguments[:height],
        width: system_arguments[:width]
      )

      @system_arguments = system_arguments
      @system_arguments[:tag] = :svg
      @system_arguments[:aria] ||= {}
      @use_symbol = use_symbol

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
          height: @system_arguments[:height] || SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, SIZE_DEFAULT)],
          width: @system_arguments[:width]
        }
        octicon_options.compact!

        @icon = Octicons::Octicon.new(icon_key, octicon_options)
        Primer::Octicon::Cache.set(cache_key, @icon)
      end

      @system_arguments[:classes] = class_names(
        @icon.options[:class],
        @system_arguments[:classes]
      )
      @system_arguments.merge!(@icon.options.except(:class, :'aria-hidden'))
    end
  end
end
