# frozen_string_literal: true

module Primer
  module Alpha
    class ActionList
      # Heading used to describe each sub list within an action list.
      class Heading < Primer::Component
        warn_on_deprecated_slot_setter

        DEFAULT_SCHEME = :subtle
        SCHEME_MAPPINGS = {
          DEFAULT_SCHEME => nil,
          :filled => "ActionList-sectionDivider--filled"
        }.freeze
        SCHEME_OPTIONS = SCHEME_MAPPINGS.keys.freeze

        # @param list_id [String] The unique identifier of the sub list the heading belongs to. Used internally.
        # @param title [String] Sub list title.
        # @param subtitle [String] Optional sub list description.
        # @param scheme [Symbol] Display a background color if scheme is `filled`.
        # @param tag [Symbol] Semantic tag for the heading.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(list_id:, title:, tag: :h3, scheme: DEFAULT_SCHEME, subtitle: nil, **system_arguments)
          @tag = tag
          @system_arguments = system_arguments
          @list_id = list_id
          @title = title
          @subtitle = subtitle
          @scheme = fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)
          @system_arguments[:tag] = :li
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
