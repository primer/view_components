# frozen_string_literal: true

module Primer
  # Renders an [Octicon](https://primer.style/octicons/) with <%= link_to_system_arguments_docs %>.
  class OcticonComponent < Primer::Component
    include Primer::ClassNameHelper
    include OcticonsHelper

    SIZE_DEFAULT = :small
    SIZE_MAPPINGS = {
      SIZE_DEFAULT => 16,
      :medium => 32,
      :large => 64,
    }.freeze
    SIZE_OPTIONS = SIZE_MAPPINGS.keys

    # @example 25|Default
    #   <%= render(Primer::OcticonComponent.new(icon: "check")) %>
    #
    # @example 40|Medium
    #   <%= render(Primer::OcticonComponent.new(icon: "people", size: :medium)) %>
    #
    # @example 80|Large
    #   <%= render(Primer::OcticonComponent.new(icon: "x", size: :large)) %>
    #
    # @param icon [String] Name of [Octicon](https://primer.style/octicons/) to use.
    # @param size [Symbol] <%= one_of(Primer::OcticonComponent::SIZE_MAPPINGS) %>
    # @param kwargs [Hash] <%= link_to_system_arguments_docs %>
    def initialize(icon:, size: SIZE_DEFAULT, **kwargs)
      @icon, @kwargs = icon, kwargs

      @kwargs[:class] = Primer::Classify.call(**@kwargs)[:class]
      @kwargs[:height] ||= SIZE_MAPPINGS[size]

      # Filter out classify options to prevent them from becoming invalid html attributes.
      # Note height and width are both classify options and valid html attributes.
      octicon_helper_options = @kwargs.slice(:height, :width)
      @kwargs = @kwargs.except(*Primer::Classify::VALID_KEYS, :classes).merge(octicon_helper_options)
    end

    def call
      octicon(@icon, **@kwargs)
    end
  end
end
