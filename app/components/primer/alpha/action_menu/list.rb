# frozen_string_literal: true

module Primer
  module Alpha
    class ActionMenu
      # This component is part of <%= link_to_component(Primer::Alpha::ActionMenu) %> and should not be
      # used as a standalone component.
      class List < Primer::Alpha::ActionList
        add_polymorphic_slot_type(
          slot_name: :items,
          type: :group,
          callable: lambda { |**system_arguments|
            Primer::Alpha::ActionMenu::Group.new(
              **system_arguments,
              role: :group,
              select_variant: @select_variant
            )
          }
        )

        # @param menu_id [String] ID of the parent menu.
        # @param system_arguments [Hash] The arguments accepted by <%= link_to_component(Primer::Alpha::ActionList) %>
        def initialize(menu_id:, **system_arguments, &block)
          @menu_id = menu_id

          system_arguments[:aria] = merge_aria(
            system_arguments,
            { aria: { labelledby: "#{@menu_id}-button" } }
          )

          system_arguments[:role] = :menu
          system_arguments[:scheme] = :inset
          system_arguments[:id] = "#{@menu_id}-list"

          super(**system_arguments, &block)
        end

        def with_item(**system_arguments, &block)
          with_group do |group|
            group.with_item(**system_arguments, &block)
          end
        end

        def with_avatar_item(**system_arguments, &block)
          with_group do |group|
            group.with_avatar_item(**system_arguments, &block)
          end
        end
      end
    end
  end
end
