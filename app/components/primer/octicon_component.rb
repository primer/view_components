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
      cache_key = [icon_key, size, system_arguments.slice(:height, :width)].join("_")

      @system_arguments = system_arguments
      @system_arguments[:tag] = :svg

      if (cache_icon = Primer::OcticonComponent::Cache.read(cache_key))
        @icon = cache_icon
      else
        # Filter out classify options to prevent them from becoming invalid html attributes.
        # Note height and width are both classify options and valid html attributes.
        octicon_options = {
          height: SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, SIZE_DEFAULT)]
        }.merge(@system_arguments.slice(:height, :width))

        @icon = Octicons::Octicon.new(icon_key, octicon_options)
        Primer::OcticonComponent::Cache.set(cache_key, @icon)
      end

      @system_arguments[:classes] = class_names(
        @icon.options[:class],
        @system_arguments[:classes]
      )
      @system_arguments.merge!(@icon.options.except(:class))
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { @icon.path.html_safe } # rubocop:disable Rails/OutputSafety
    end

    # :nodoc:
    class Cache
      LOOKUP = {} # rubocop:disable Style/MutableConstant

      # Cache size limit.
      LIMIT = 500

      class << self
        def read(key)
          LOOKUP[key]
        end

        def set(key, value)
          LOOKUP[key] = value

          # Remove first item when the cache is too large.
          LOOKUP.shift if LOOKUP.size > LIMIT
        end

        def clear!
          LOOKUP.clear
        end

        def preload!
          # Preload the top 20 icons.
          Primer::OcticonComponent.new(icon: :alert)
          Primer::OcticonComponent.new(icon: :check)
          Primer::OcticonComponent.new(icon: :"chevron-down")
          Primer::OcticonComponent.new(icon: :clippy)
          Primer::OcticonComponent.new(icon: :clock)
          Primer::OcticonComponent.new(icon: :"dot-fill")
          Primer::OcticonComponent.new(icon: :info)
          Primer::OcticonComponent.new(icon: :"kebab-horizontal")
          Primer::OcticonComponent.new(icon: :link)
          Primer::OcticonComponent.new(icon: :lock)
          Primer::OcticonComponent.new(icon: :mail)
          Primer::OcticonComponent.new(icon: :pencil)
          Primer::OcticonComponent.new(icon: :plus)
          Primer::OcticonComponent.new(icon: :question)
          Primer::OcticonComponent.new(icon: :repo)
          Primer::OcticonComponent.new(icon: :search)
          Primer::OcticonComponent.new(icon: :"shield-lock")
          Primer::OcticonComponent.new(icon: :star)
          Primer::OcticonComponent.new(icon: :trash)
          Primer::OcticonComponent.new(icon: :x)
        end
      end
    end

    Cache.preload!
  end
end
