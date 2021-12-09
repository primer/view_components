# frozen_string_literal: true

module Primer
  module Alpha
    class NavigationList
      # Section heading rendered above the section contents.
      class Heading < Primer::Component
        # @param section_id [String] The unique identifier of the section the heading belongs to.
        # @param filled [Boolean] Whether or not the section is filled, i.e. has a colored background.
        # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
        def initialize(section_id:, filled: false, **system_arguments)
          @system_arguments = system_arguments
          @system_arguments[:tag] = :li
          @system_arguments[:id] = section_id
          @system_arguments[:classes] = class_names(
            "ActionList-sectionDivider",
            filled ? "ActionList-sectionDivider--filled" : "",
            @system_arguments[:classes]
          )
        end

        def before_render
          @system_arguments[:"aria-hidden"] = true if content.present?
        end
      end
    end
  end
end
