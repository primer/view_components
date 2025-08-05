# frozen_string_literal: true

module Primer
  module Alpha
    class ActionMenu
      # This component is part of <%= link_to_component(Primer::Alpha::ActionMenu) %> and should not be
      # used as a standalone component.
      class SubMenuItem < ::Primer::Alpha::ActionList::Item
        def initialize(content_arguments: {}, form_arguments: {}, **system_arguments)
          # We extract form_arguments from system_arguments here to avoid passing them to the
          # ActionList::Item base class or to the SubMenu instance. Doing so prevents a form
          # input from being emitted for sub-menu items, which prevents an extra empty value
          # from being sent to the server on form submit.
          @sub_menu = SubMenu.allocate
          system_arguments = @sub_menu.send(:initialize, **system_arguments)
          system_arguments[:id] = "#{@sub_menu.menu_id}-button"

          @form_arguments = form_arguments

          content_arguments[:tag] = :button
          content_arguments[:popovertarget] = "#{@sub_menu.menu_id}-overlay"

          content_arguments[:aria] = merge_aria(
            content_arguments, {
              aria: {
                controls: "#{@sub_menu.menu_id}-list",
                haspopup: true
              }
            }
          )

          super
        end

        def with_item(**system_arguments, &block)
          @sub_menu.with_item(form_arguments: @form_arguments, **system_arguments, &block)
        end

        def with_divider(**system_arguments, &block)
          @sub_menu.with_divider(form_arguments: @form_arguments, **system_arguments, &block)
        end

        def with_avatar_item(**system_arguments, &block)
          @sub_menu.with_avatar_item(form_arguments: @form_arguments, **system_arguments, &block)
        end

        def with_sub_menu_item(**system_arguments, &block)
          @sub_menu.with_sub_menu_item(form_arguments: @form_arguments, **system_arguments, &block)
        end

        def with_group(**system_arguments, &block)
          @sub_menu.with_group(form_arguments: @form_arguments, **system_arguments, &block)
        end
      end
    end
  end
end
