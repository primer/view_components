# frozen_string_literal: true

module Primer
  module Alpha
    class ActionList
      # Section heading used to describe each group of action list items within an action list.
      class Heading < Primer::Component
        DEFAULT_SCHEME = :subtle
        SCHEME_MAPPINGS = {
          DEFAULT_SCHEME => nil,
          :filled => "ActionList-sectionDivider--filled"
        }.freeze
        SCHEME_OPTIONS = SCHEME_MAPPINGS.keys.freeze

        # @param section_id [String] The unique identifier of the section the heading belongs to.
        # @param title [String] Group title.
        # @param subtitle [String] Optional group description.
        # @param scheme [Symbol] Display a background color if scheme is `filled`.
        # @param tag [Symbol] Semantic tag for the heading.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(section_id:, title:, tag: :h3, scheme: DEFAULT_SCHEME, subtitle: nil, **system_arguments)
          @tag = tag
          @system_arguments = system_arguments
          @section_id = section_id
          @title = title
          @subtitle = subtitle
          @scheme = fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)
          @system_arguments[:tag] = :div
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
