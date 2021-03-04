# frozen_string_literal: true

module Primer
  # Renders an [Octicon](https://primer.style/octicons/) with <%= link_to_system_arguments_docs %>.
  class OcticonComponent < Primer::Component
    view_helper :octicon

    include ClassNameHelper
    include TestSelectorHelper
    include OcticonsHelper

    SIZE_DEFAULT = :small
    SIZE_MAPPINGS = {
      SIZE_DEFAULT => 16,
      :medium => 32,
      :large => 64
    }.freeze
    SIZE_OPTIONS = SIZE_MAPPINGS.keys

    # @example Default
    #   <%= render(Primer::OcticonComponent.new(icon: "check")) %>
    #
    # @example Medium
    #   <%= render(Primer::OcticonComponent.new(icon: "people", size: :medium)) %>
    #
    # @example Large
    #   <%= render(Primer::OcticonComponent.new(icon: "x", size: :large)) %>
    #
    # @param icon [String] Name of [Octicon](https://primer.style/octicons/) to use.
    # @param size [Symbol] <%= one_of(Primer::OcticonComponent::SIZE_MAPPINGS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(icon:, size: SIZE_DEFAULT, **system_arguments)
      @icon = icon
      @system_arguments = system_arguments

      @system_arguments[:class] = Primer::Classify.call(**@system_arguments)[:class]
      @system_arguments[:height] ||= SIZE_MAPPINGS[size]

      # Filter out classify options to prevent them from becoming invalid html attributes.
      # Note height and width are both classify options and valid html attributes.
      octicon_helper_options = @system_arguments.slice(:height, :width)
      @system_arguments = add_test_selector(@system_arguments).except(*Primer::Classify::VALID_KEYS, :classes).merge(octicon_helper_options)
    end

    def call
      octicon(@icon, { **@system_arguments })
    end

    def self.status
      Primer::Component::STATUSES[:beta]
    end
  end
end
