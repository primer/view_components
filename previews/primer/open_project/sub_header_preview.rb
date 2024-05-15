# frozen_string_literal: true

# Setup Playground to use all available component props
# Setup Features to use individual component props and combinations

module Primer
  module OpenProject
    # @label SubHeader
    class SubHeaderPreview < ViewComponent::Preview
      # @label Playground
      # @param show_filter_input toggle
      # @param button_type [Symbol] select [Button, IconButton, ActionMenu, Dialog, ButtonGroup]
      # @param text text
      def playground(show_filter_input: true, button_type: :button, text: nil)
        render(Primer::OpenProject::SubHeader.new) do |component|
          component.with_filter_input(name: "filter", label: "Filter") if show_filter_input

          component.with_text { text } unless text.nil?

          case button_type
          when :"ActionMenu"
            component.with_menu_button(menu_arguments: { anchor_align: :end },
                                       button_arguments: { icon: "op-kebab-vertical", aria: { label: "Menu" }}) do |menu|
              menu.with_item(label: "Subitem 1") do |item|
                item.with_leading_visual_icon(icon: :paste)
              end
              menu.with_item(label: "Subitem 2") do |item|
                item.with_leading_visual_icon(icon: :log)
              end
            end
          when :"Dialog"
            callback = lambda do |button|
              button.with_trailing_visual_icon(icon: :history)
              "Open dialog"
            end

            component.with_dialog_button(dialog_arguments: { id: "my_dialog", title: "A great dialog" },
                                         button_arguments: { button_block: callback }) do |d|
              d.with_body { "Hello" }
            end

          when :"ButtonGroup"
            component.with_button_group do |group|
              group.with_button(id: "button-1", tag: :button) do |button|
                button.with_tooltip(text: "Button Tooltip")
                "Button 1"
              end
              group.with_button(id: "button-2", tag: :a, href: "#") do |button|
                button.with_tooltip(text: "Button Tooltip")
                "Button 2"
              end
            end
          when :"IconButton"
            component.with_button(icon: :plus, aria: { label: "Create" })
          else
            component.with_button(scheme: :primary) do |button|
              button.with_leading_visual_icon(icon: :plus)
              "Create"
            end
          end
        end
      end

      # @label Default
      def default
        render(Primer::OpenProject::SubHeader.new) do |component|
          component.with_filter_input(name: "filter", label: "Filter")

          component.with_button(scheme: :primary)  do |button|
            button.with_leading_visual_icon(icon: :plus)
            "Create"
          end
        end
      end

      # @label With ActionMenu
      def action_menu_buttons
        render(Primer::OpenProject::SubHeader.new) do |component|
          component.with_filter_input(name: "filter", label: "Filter")
          component.with_menu_button(menu_arguments: { anchor_align: :end },
                                     button_arguments: { icon: "op-kebab-vertical", aria: { label: "Menu" }}) do |menu|
            menu.with_item(label: "Subitem 1") do |item|
              item.with_leading_visual_icon(icon: :paste)
            end
            menu.with_item(label: "Subitem 2") do |item|
              item.with_leading_visual_icon(icon: :log)
            end
          end
        end
      end

      # @label With Dialog
      def dialog_buttons
        callback = lambda do |button|
          button.with_trailing_visual_icon(icon: :history)
          "Open dialog"
        end

        render(Primer::OpenProject::SubHeader.new) do |component|
          component.with_filter_input(name: "filter", label: "Filter")
          component.with_dialog_button(dialog_arguments: { id: "my_dialog", title: "A great dialog" },
                                       button_arguments: { button_block: callback }) do |d|
            d.with_body { "Hello" }
          end
        end
      end

      # @label With ButtonGroup
      def button_group
        render(Primer::OpenProject::SubHeader.new) do |component|
          component.with_filter_input(name: "filter", label: "Filter")

          component.with_button_group do |group|
            group.with_button(id: "button-1", tag: :button) do |button|
              button.with_tooltip(text: "Button Tooltip")
              "Button 1"
            end
            group.with_button(id: "button-2", tag: :a, href: "#") do |button|
              button.with_tooltip(text: "Button Tooltip")
              "Button 2"
            end
          end
        end
      end

      # @label With Text in the middle
      def text
        render(Primer::OpenProject::SubHeader.new) do |component|
          component.with_filter_input(name: "filter", label: "Filter")

          component.with_text { "Hello world!" }

          component.with_button(scheme: :primary)  do |button|
            button.with_leading_visual_icon(icon: :plus)
            "Create"
          end
        end
      end
    end
  end
end
