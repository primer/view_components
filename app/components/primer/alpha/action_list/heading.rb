# frozen_string_literal: true

module Primer
  module Alpha
    class ActionList
      # Heading used to describe each sub list within an action list.
      class Heading < Primer::Component
        DEFAULT_SCHEME = :subtle
        SCHEME_MAPPINGS = {
          DEFAULT_SCHEME => nil,
          :filled => "ActionList-sectionDivider--filled"
        }.freeze
        SCHEME_OPTIONS = SCHEME_MAPPINGS.keys.freeze
        HEADING_MIN = 1
        HEADING_MAX = 6
        HEADING_LEVELS = (HEADING_MIN..HEADING_MAX).to_a.freeze

        # @param list_id [String] The unique identifier of the sub list the heading belongs to. Used internally.
        # @param title [String] Sub list title.
        # @param heading_level [Integer] Heading level. Level 2 results in an `<h2>` tag, level 3 an `<h3>` tag, etc.
        # @param subtitle [String] Optional sub list description.
        # @param scheme [Symbol] Display a background color if scheme is `filled`.
        # @param tag [Integer] Semantic tag for the heading.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(list_id:, title:, heading_level: 3, scheme: DEFAULT_SCHEME, subtitle: nil, **system_arguments)
          raise "Heading level must be between #{HEADING_MIN} and #{HEADING_MAX}" unless HEADING_LEVELS.include?(heading_level)

          @heading_level = heading_level
          @tag = :"h#{heading_level}"
          @system_arguments = system_arguments
          @list_id = list_id
          @title = title
          @subtitle = subtitle
          @scheme = fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)
          @system_arguments[:classes] = class_names(
            "ActionList-sectionDivider",
            SCHEME_MAPPINGS[@scheme],
            @system_arguments[:classes]
          )
        end
      end
    end
  end
end
