# frozen_string_literal: true

module Primer
  module Beta
    # Use `ProgressBar` to visualize task completion.
    class ProgressBar < Primer::Component
      status :beta

      # Use the Item slot to add an item to the progress bar
      #
      # @param percentage [Integer] The percent complete
      # @param bg [Symbol] The background color
      # @param kwargs [Hash] The same arguments as <%= link_to_system_arguments_docs %>.
      renders_many :items, lambda { |percentage: 0, bg: :success_emphasis, **system_arguments|
        deny_tag_argument(**system_arguments)
        system_arguments[:tag] = :span
        system_arguments[:bg] = bg
        system_arguments[:style] = join_style_arguments(system_arguments[:style], "width: #{percentage}%;")
        system_arguments[:classes] = class_names("Progress-item", system_arguments[:classes])

        Primer::BaseComponent.new(**system_arguments)
      }

      SIZE_DEFAULT = :default

      SIZE_MAPPINGS = {
        SIZE_DEFAULT => "",
        :small => "Progress--small",
        :large => "Progress--large"
      }.freeze

      SIZE_OPTIONS = SIZE_MAPPINGS.keys

      # @param size [Symbol] <%= one_of(Primer::Beta::ProgressBar::SIZE_OPTIONS) %> Increases height.
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(size: SIZE_DEFAULT, **system_arguments)
        @system_arguments = deny_tag_argument(**system_arguments)
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "Progress",
          SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, size, SIZE_DEFAULT)]
        )
        @system_arguments[:tag] = :span
      end

      def render?
        items?
      end
    end
  end
end
