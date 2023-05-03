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

        attr_reader :title_id, :subtitle_id

        # @param title [String] Sub list title.
        # @param heading_level [Integer] Heading level. Level 2 results in an `<h2>` tag, level 3 an `<h3>` tag, etc.
        # @param subtitle [String] Optional sub list description.
        # @param scheme [Symbol] Display a background color if scheme is `filled`.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(title:, heading_level: 3, scheme: DEFAULT_SCHEME, subtitle: nil, **system_arguments)
          raise "Heading level must be between #{HEADING_MIN} and #{HEADING_MAX}" unless HEADING_LEVELS.include?(heading_level)

          @heading_level = heading_level
          @tag = :"h#{heading_level}"
          @system_arguments = deny_tag_argument(**system_arguments)
          @title = title
          @subtitle = subtitle
          @scheme = fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)
          @system_arguments[:classes] = class_names(
            "ActionList-sectionDivider",
            SCHEME_MAPPINGS[@scheme],
            @system_arguments[:classes]
          )

          @title_id = self.class.generate_id(base_name: "heading-title")
          @subtitle_id = self.class.generate_id(base_name: "heading-subtitle")
        end

        def subtitle?
          @subtitle.present?
        end
      end
    end
  end
end
