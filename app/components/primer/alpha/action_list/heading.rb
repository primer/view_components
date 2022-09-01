# frozen_string_literal: true

module Primer
  module Alpha
    class ActionList
      # Section heading rendered above the section contents.
      class Heading < Primer::Component

        DEFAULT_SCHEME = :subtle
        SCHEME_MAPPINGS = {
          DEFAULT_SCHEME => nil,
          :filled => "ActionList-sectionDivider--filled"
        }.freeze
        SCHEME_OPTIONS = SCHEME_MAPPINGS.keys.freeze

        # @param section_id [String] The unique identifier of the section the heading belongs to.
        # @param filled [Boolean] Whether or not the section is filled, i.e. has a colored background.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(section_id:, title:, scheme: DEFAULT_SCHEME, subtitle: nil, **system_arguments)
          @system_arguments = system_arguments
          @system_arguments[:tag] = :li
          @section_id = section_id
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
