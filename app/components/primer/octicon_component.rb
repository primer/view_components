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
      @system_arguments = system_arguments
      @system_arguments[:tag] = :svg

      # Filter out classify options to prevent them from becoming invalid html attributes.
      # Note height and width are both classify options and valid html attributes.
      octicon_options = {
        height: SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, SIZE_DEFAULT)]
      }.merge(@system_arguments.slice(:height, :width, :class))

      @icon = Octicons::Octicon.new(icon_name || icon, octicon_options)

      @system_arguments[:classes] = [@icon.options[:class], @system_arguments[:classes]].compact.join(" ")
      @system_arguments.merge!(@icon.options.reject { |k| [:class].include?(k) })
      # puts octicon_options.inspect
      # puts @system_arguments.inspect
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) { @icon.path.html_safe }
    end
  end
end
