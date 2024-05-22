# frozen_string_literal: true

module Primer
  module OpenProject
    # The SubHeader contains specific actions to modify the page content below, e.g a filter button or a create button
    # It should not be used stand alone, but in combination with a PageHeader, either as a direct sibling or as part of a tab content
    class SubHeader < Primer::Component
      status :open_project

      renders_many :buttons, types: {
        button: {
          renders: lambda { |icon: nil, **kwargs|
            kwargs[:classes] = class_names(
              kwargs[:classes],
              "SubHeader-button"
            )
            if icon
              Primer::Beta::IconButton.new(icon: icon, **kwargs)
            else
              Primer::Beta::Button.new(**kwargs)
            end
          },

          as: :button
        },

        menu_button: {
          renders: lambda { |menu_arguments: {}, button_arguments: {}|
            button_arguments[:classes] = class_names(
              button_arguments[:classes],
              "SubHeader-button"
            )
            Primer::OpenProject::PageHeader::Menu.new(menu_arguments: menu_arguments, button_arguments: button_arguments)
          },

          as: :menu_button
        },

        dialog_button: {
          renders: lambda { |dialog_arguments: {}, button_arguments: {}|
            button_arguments[:classes] = class_names(
              button_arguments[:classes],
              "SubHeader-button"
            )

            Primer::OpenProject::PageHeader::Dialog.new(dialog_arguments: dialog_arguments, button_arguments: button_arguments)
          },

          as: :dialog_button
        },

        group_button: {
          renders: lambda { |**kwargs|
            kwargs[:classes] = class_names(
              kwargs[:classes],
              "SubHeader-button"
            )

            Primer::Beta::ButtonGroup.new(**kwargs)
          },

          as: :button_group
        }
      }

      renders_one :filter_input, lambda { |name:, label:, **system_arguments|
        system_arguments[:classes] = class_names(
          system_arguments[:classes],
          "SubHeader-filterInput"
        )
        system_arguments[:placeholder] ||= I18n.t("button_filter")
        system_arguments[:leading_visual] ||= { icon: :search }
        system_arguments[:visually_hide_label] ||= true

        system_arguments[:data] ||= {}
        system_arguments[:data][:target]= "sub-header.filterInput"

        @mobile_filter_trigger = Primer::Beta::IconButton.new(icon: system_arguments[:leading_visual][:icon],
                                                              display: [:inline_flex, :none],
                                                              aria: {label: label },
                                                              "data-action": "click:sub-header#expandFilterInput",
                                                              "data-targets": "sub-header.hiddenItemsOnExpandedFilter")

        Primer::Alpha::TextField.new(name: name, label: label, **system_arguments)
      }

      renders_one :text, lambda { |**system_arguments|
        system_arguments[:font_weight] ||= :bold

        Primer::Beta::Text.new(**system_arguments)

      }


      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = :"sub-header"

        @system_arguments[:classes] = class_names(
          "SubHeader",
          system_arguments[:classes]
        )
      end
    end
  end
end
