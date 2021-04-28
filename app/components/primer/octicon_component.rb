# frozen_string_literal: true

require "octicons"

module Primer
  # `Octicon` renders an <%= link_to_octicons %> with <%= link_to_system_arguments_docs %>.
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
    # @param icon [String] Name of <%= link_to_octicons %> to use.
    # @param size [Symbol] <%= one_of(Primer::OcticonComponent::SIZE_MAPPINGS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(icon_name = nil, icon: nil, size: SIZE_DEFAULT, **system_arguments)
      icon_key = icon_name || icon
      cache_key = [icon_key, size, system_arguments].to_s

      if cache_icon = Primer::OcticonComponent::Cache.read(cache_key)
        @icon, @system_arguments = cache_icon
      else
        @system_arguments = system_arguments
        @system_arguments[:tag] = :svg

        # Filter out classify options to prevent them from becoming invalid html attributes.
        # Note height and width are both classify options and valid html attributes.
        octicon_options = {
          height: SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, SIZE_DEFAULT)]
        }.merge(@system_arguments.slice(:height, :width, :class))

        @icon = Octicons::Octicon.new(icon_key, octicon_options)

        @system_arguments[:classes] = class_names(
          @icon.options[:class],
          @system_arguments[:classes]
        )
        @system_arguments.merge!(@icon.options.except(:class))

        Primer::OcticonComponent::Cache.set(cache_key, [@icon, @system_arguments])
      end
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { @icon.path.html_safe } # rubocop:disable Rails/OutputSafety
    end

    # :nodoc:
    class Cache
      # rubocop:disable Style/MutableConstant
      LOOKUP = {}
      # rubocop:enable Style/MutableConstant

      class <<self
        def read(key)
          LOOKUP[key]
        end

        def set(key, value)
          LOOKUP[key] = value
        end

        def clear!
          LOOKUP.clear
        end
      end
    end
  end
end
