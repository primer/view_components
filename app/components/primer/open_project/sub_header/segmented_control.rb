# frozen_string_literal: true

module Primer
  module OpenProject
    # A Helper class to create SegmentedControls inside the SubHeader action slot
    # Do not use standalone
    class SubHeader::SegmentedControl < Primer::Alpha::SegmentedControl
      status :open_project

      def with_item(icon:, **system_arguments, &block)
        system_arguments[:icon] = icon
        super(component_klass: Primer::OpenProject::SubHeader::SegmentedControl, **system_arguments, &block)
      end
    end
  end
end
