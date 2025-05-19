# frozen_string_literal: true

module Primer
  module OpenProject
    # A Helper class to create ButtonGroups inside the SubHeader action slot
    # Do not use standalone
    class SubHeader::ButtonGroup < Primer::Beta::ButtonGroup
      status :open_project

      def with_button(icon:, **system_arguments, &block)
        system_arguments[:icon] = icon
        super(component_klass: Primer::OpenProject::SubHeader::ButtonGroup, **system_arguments, &block)
      end
    end
  end
end
