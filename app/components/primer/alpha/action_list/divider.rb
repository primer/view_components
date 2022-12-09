# frozen_string_literal: true

module Primer
  module Alpha
    class ActionList
      # Section heading rendered above the section contents.
      class Divider < Primer::Component
        warn_on_deprecated_slot_setter

        DEFAULT_SCHEME = :subtle
        SCHEME_MAPPINGS = {
          DEFAULT_SCHEME => nil,
          :filled => "ActionList-sectionDivider--filled"
        }.freeze
        SCHEME_OPTIONS = SCHEME_MAPPINGS.keys.freeze

        # @param scheme [Symbol] Display a background color if scheme is `filled`.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(scheme: DEFAULT_SCHEME, **system_arguments)
          @system_arguments = system_arguments
          @system_arguments[:tag] = :li
          @system_arguments[:role] = :separator
          @system_arguments[:'aria-hidden'] = true
          @scheme = fetch_or_fallback(SCHEME_OPTIONS, scheme, DEFAULT_SCHEME)
          @system_arguments[:classes] = class_names(
            "ActionList-sectionDivider",
            SCHEME_MAPPINGS[@scheme]
          )
        end

        def call
          render(Primer::BaseComponent.new(**@system_arguments)) { "" }
        end
      end
    end
  end
end
