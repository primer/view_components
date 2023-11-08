# typed: true
# frozen_string_literal: true

module Primer
  module Alpha
    class ActionMenu
      # This component is part of <%= link_to_component(Primer::Alpha::ActionMenu) %> and should not be
      # used as a standalone component.
      class Group < Primer::Alpha::ActionList
        # Heading text rendered above the list of items.
        #
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionMenu::Heading) %>.
        def with_heading(**system_arguments, &block)
          super(component_klass: Primer::Alpha::ActionMenu::Heading, **system_arguments, &block)
        end

        def with_divider
          raise "ActionMenu groups cannot have dividers"
        end
      end
    end
  end
end
